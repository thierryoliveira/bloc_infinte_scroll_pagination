import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_bloc/core/colors/app_colors.dart';
import 'package:infinite_scroll_bloc/core/widgets/custom_ticket_shape.dart';
import 'package:infinite_scroll_bloc/domain/entities/passanger.entity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PassengersSliverList extends StatelessWidget {
  final PagingController<int, PassengerEntity> pagingController;
  const PassengersSliverList({super.key, required this.pagingController});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PagedSliverList<int, PassengerEntity>.separated(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<PassengerEntity>(
        itemBuilder: (context, item, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipPath(
                clipper: CustomTicketShape(),
                child: Container(
                  constraints: BoxConstraints(
                      minWidth: size.width * .9, minHeight: size.height * .1),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                  color: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? 'no name',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text(
                                ('${item.airline?.last.name} - ${item.airline?.last.country}')),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SizedBox(
                              height: size.height * .08,
                              child: VerticalDivider(
                                thickness: 2,
                                color: AppColors.grey.withOpacity(.26),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.plane,
                                color: AppColors.purple,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child:
                                    Text(item.trips?.toString() ?? 'No trips'),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
                // child: ListTile(
                //   contentPadding: const EdgeInsets.all(16),
                //   tileColor: AppColors.white,
                //   title: Text(
                //     item.name ?? 'no name',
                //     style: const TextStyle(
                //         fontWeight: FontWeight.w600, fontSize: 20),
                //   ),
                //   subtitle: Text(
                //       ('${item.airline?.last.name} - ${item.airline?.last.country}')),
                //   trailing: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const Icon(FontAwesomeIcons.plane),
                //       Text(item.trips?.toString() ?? 'No trips'),
                //     ],
                //   ),
                // ),
                ),
          );
        },
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
