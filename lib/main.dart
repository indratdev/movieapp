import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/blocs/login_bloc/login_bloc.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';

import 'package:movie_app/shared/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => MovieBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes().getRoutes,
        initialRoute: AppRoutes.splashScreen,
        theme: ThemeData(
          primaryColor: const Color(0xffe4e3e8),
          // appBarTheme: AppBarTheme(
          //   color: ColorsApp.greenApp,
          // ),
        ),
      ),
    );
  }
}

// Color(0xff4c9acc),
// Color(0xff325372),