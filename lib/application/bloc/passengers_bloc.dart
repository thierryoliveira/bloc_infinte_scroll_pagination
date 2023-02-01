import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_bloc/domain/entities/page_info.entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../domain/entities/passanger.entity.dart';

part 'passengers_event.dart';
part 'passengers_state.dart';

class PassengersBloc extends Bloc<PassengersEvent, PassengersState> {
  PassengersBloc() : super(PassengersInitial()) {
    on<GetAllPassengers>(_onGetAllPassengers);
  }

  FutureOr<void> _onGetAllPassengers(
      GetAllPassengers event, Emitter<PassengersState> emit) async {
    final oldItems = state is PassengersLoaded
        ? (state as PassengersLoaded).pagingState.itemList
        : null;
    emit(PassengersLoading(oldItems: oldItems));
    try {
      final Dio dio = Dio();
      final mapResult = await dio.get(
          'https://api.instantwebtools.net/v1/passenger?page=${event.pageIndex}&size=10');
      final parsedResult = PageInfoEntity.fromJson(mapResult.data);

      final List<PassengerEntity> allItems = [
        ...?oldItems,
        ...parsedResult.passengers ?? []
      ];
      emit(PassengersLoaded(
          pagingState: PagingState<int, PassengerEntity>(
              itemList: allItems, nextPageKey: event.pageIndex + 1)));
    } on DioError catch (e) {
      emit(PassengersError(message: e.message));
    } catch (e) {
      emit(PassengersError(message: e.toString()));
    }
  }
}
