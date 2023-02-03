import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_bloc/application/widgets/passengers_sliver_list.dart';
import 'package:infinite_scroll_bloc/core/colors/app_colors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../domain/entities/passanger.entity.dart';
import '../bloc/passengers_bloc.dart';

class PassengersPage extends StatefulWidget {
  const PassengersPage({super.key});

  @override
  State<PassengersPage> createState() => _PassengersPageState();
}

class _PassengersPageState extends State<PassengersPage> {
  final PagingController<int, PassengerEntity> _pagingController =
      PagingController(firstPageKey: 0);
  late final PassengersBloc _passengersBloc;

  @override
  void initState() {
    super.initState();
    _passengersBloc = context.read<PassengersBloc>();

    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 0) {
        _passengersBloc.add(GetAllPassengers(pageIndex: pageKey));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: AppColors.purple,
          actions: [
            IconButton(
                onPressed: () =>
                    _passengersBloc.add(GetAllPassengers(pageIndex: 0)),
                icon: const Icon(FontAwesomeIcons.arrowsRotate)),
          ],
          expandedHeight: 120,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Passangers list'),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        BlocConsumer<PassengersBloc, PassengersState>(
          listener: (context, state) {
            if (state is PassengersLoaded) {
              _pagingController.value = state.pagingState;
            }
          },
          buildWhen: (previous, current) => current is! PassengersLoading,
          builder: (context, state) {
            if (state is PassengersLoaded) {
              return PassengersSliverList(
                pagingController: _pagingController,
              );
            } else if (state is PassengersError) {
              return SliverToBoxAdapter(
                child: Center(child: Text(state.message)),
              );
            } else {
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
