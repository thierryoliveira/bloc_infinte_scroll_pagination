import 'package:dio/dio.dart';
import 'package:infinite_scroll_bloc/core/errors/exceptions/passengers_exception.dart';

import 'package:infinite_scroll_bloc/data/datasources/passenger/passengers_datasource.dart';

import '../../../domain/entities/page_info.entity.dart';

class PassengersDatasourceImpl implements PassengersDatasource {
  final Dio _client;
  PassengersDatasourceImpl({
    required Dio client,
  }) : _client = client;

  @override
  Future<PageInfoEntity> getPassengers(int pageIndex) async {
    try {
      final mapResult = await _client.get('/passenger?page=$pageIndex&size=10');
      return PageInfoEntity.fromJson(mapResult.data);
    } on DioError catch (e) {
      throw PassengersException(message: e.message);
    } catch (e) {
      throw PassengersException(message: 'Something went wrong...');
    }
  }
}
