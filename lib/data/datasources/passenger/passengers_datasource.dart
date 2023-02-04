import 'package:infinite_scroll_bloc/domain/entities/page_info.entity.dart';

abstract class PassengersDatasource {
  Future<PageInfoEntity> getPassengers(int pageIndex);
}
