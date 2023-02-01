import 'package:flutter/material.dart';
import 'package:infinite_scroll_bloc/domain/entities/passanger.entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PassengersSliverList extends StatelessWidget {
  final PagingController<int, PassengerEntity> pagingController;
  const PassengersSliverList({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    return PagedSliverList<int, PassengerEntity>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<PassengerEntity>(
          itemBuilder: (context, item, index) {
            return ListTile(
              leading: Text(index.toString()),
              title: Text(item.name ?? 'no name'),
              trailing: Text(item.trips?.toString() ?? 'no trips'),
            );
          },
        ));
  }
}
