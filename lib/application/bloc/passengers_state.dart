part of 'passengers_bloc.dart';

abstract class PassengersState {}

class PassengersInitial extends PassengersState {}

class PassengersLoading extends PassengersState {
  final List<PassengerEntity>? oldItems;
  PassengersLoading({
    this.oldItems,
  });
}

class PassengersLoaded extends PassengersState {
  final PagingState<int, PassengerEntity> pagingState;

  PassengersLoaded({
    required this.pagingState,
  });
}

class PassengersError extends PassengersState {
  final String message;

  PassengersError({
    required this.message,
  });
}
