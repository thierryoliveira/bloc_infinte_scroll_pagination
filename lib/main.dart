import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_bloc/application/pages/passengers.page.dart';

import 'application/bloc/passengers_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<PassengersBloc>(
        create: (context) =>
            PassengersBloc()..add(GetAllPassengers(pageIndex: 0)),
        child: const PassengersPage(),
      ),
    );
  }
}
