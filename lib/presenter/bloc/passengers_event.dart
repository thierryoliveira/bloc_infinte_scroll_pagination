part of 'passengers_bloc.dart';

abstract class PassengersEvent {}

class GetAllPassengers extends PassengersEvent {
  final int pageIndex;

  GetAllPassengers({
    required this.pageIndex,
  });
}
