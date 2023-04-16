import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkour_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:parkour_app/bloc/cubits/drawer_cubit.dart';
import 'bloc/cubits/space_cubit.dart';
import 'bloc/data_bloc/user_bloc.dart';
import 'data/auth_repo.dart';
import 'data/data_repo.dart';
import 'view/home/root.dart';

void main() {
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepo()),
        RepositoryProvider(create: (context) => DataRepo())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthBloc(
                    RepositoryProvider.of<AuthRepo>(context),
                  )),
          BlocProvider(create: (context) => DrawerCubit()),
          BlocProvider(
              create: (context) =>
                  SpaceCubit(RepositoryProvider.of<DataRepo>(context))),
          BlocProvider(
            create: (context) => BookBloc(
              RepositoryProvider.of<DataRepo>(context),
              RepositoryProvider.of<AuthRepo>(context),
            ),
          ),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "OpenSans"),
      home: const Root(),
    );
  }
}
