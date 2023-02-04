import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_bloc/core/errors/exceptions/passengers_exception.dart';
import 'package:infinite_scroll_bloc/domain/repositories/passengers_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../domain/entities/passanger.entity.dart';

part 'passengers_event.dart';
part 'passengers_state.dart';

class PassengersBloc extends Bloc<PassengersEvent, PassengersState> {
  final PassengersRepository _passengersRepository;

  PassengersBloc({required PassengersRepository passengersRepository})
      : _passengersRepository = passengersRepository,
        super(PassengersInitial()) {
    on<GetAllPassengers>(_onGetAllPassengers);
  }

  FutureOr<void> _onGetAllPassengers(
      GetAllPassengers event, Emitter<PassengersState> emit) async {
    final oldItems = state is PassengersLoaded
        ? (state as PassengersLoaded).pagingState.itemList
        : null;
    emit(PassengersLoading(oldItems: oldItems));
    try {
      final result = await _passengersRepository.getPassengers(event.pageIndex);

      final List<PassengerEntity> allItems = [
        ...?oldItems,
        ...result.passengers ?? []
      ];
      emit(PassengersLoaded(
          pagingState: PagingState<int, PassengerEntity>(
              itemList: allItems, nextPageKey: event.pageIndex + 1)));
    } on PassengersException catch (e) {
      emit(PassengersError(message: e.message));
    } catch (e) {
      emit(PassengersError(message: e.toString()));
    }
  }
}
