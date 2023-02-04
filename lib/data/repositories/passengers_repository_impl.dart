import 'package:infinite_scroll_bloc/data/datasources/passenger/passengers_datasource.dart';
import 'package:infinite_scroll_bloc/domain/entities/page_info.entity.dart';
import 'package:infinite_scroll_bloc/domain/repositories/passengers_repository.dart';

class PassengersRepositoryImpl implements PassengersRepository {
  final PassengersDatasource _passengersDatasource;

  PassengersRepositoryImpl({
    required PassengersDatasource passengersDatasource,
  }) : _passengersDatasource = passengersDatasource;

  @override
  Future<PageInfoEntity> getPassengers(int pageIndex) =>
      _passengersDatasource.getPassengers(pageIndex);
}
