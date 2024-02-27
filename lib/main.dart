import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/bloc/login_bloc.dart';
import 'package:movie_app/shared/colors_app.dart';
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
        BlocProvider(create: (context) => LoginBloc(),),
      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes().getRoutes,
        initialRoute: AppRoutes.splashScreen,
        theme: ThemeData(
          primaryColor: ColorsApp.greenApp,
          appBarTheme: AppBarTheme(
            color: ColorsApp.greenApp,
          ),
        ),
      ),
    );
  }
}
