import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_bloc/data/datasources/passenger/passengers_datasource.dart';
import 'package:infinite_scroll_bloc/data/datasources/passenger/passengers_datasource_impl.dart';
import 'package:infinite_scroll_bloc/data/repositories/passengers_repository_impl.dart';
import 'package:infinite_scroll_bloc/domain/repositories/passengers_repository.dart';

GetIt getIt = GetIt.instance;

class InjectionContainer {
  static void setup() {
    getIt.registerFactory<Dio>(
        () => Dio(BaseOptions(baseUrl: 'https://api.instantwebtools.net/v1')));
    getIt.registerFactory<PassengersDatasource>(
        () => PassengersDatasourceImpl(client: getIt.get<Dio>()));
    getIt.registerFactory<PassengersRepository>(() => PassengersRepositoryImpl(
        passengersDatasource: getIt.get<PassengersDatasource>()));
  }
}
