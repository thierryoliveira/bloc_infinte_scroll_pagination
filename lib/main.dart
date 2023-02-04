import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_bloc/core/injection/injection.dart';
import 'package:infinite_scroll_bloc/domain/repositories/passengers_repository.dart';
import 'package:infinite_scroll_bloc/presenter/pages/passengers.page.dart';

import 'presenter/bloc/passengers_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    InjectionContainer.setup();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<PassengersBloc>(
        create: (context) => PassengersBloc(
            passengersRepository: getIt.get<PassengersRepository>())
          ..add(GetAllPassengers(pageIndex: 0)),
        child: const PassengersPage(),
      ),
    );
  }
}
