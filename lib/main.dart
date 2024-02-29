import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/blocs/login_bloc/login_bloc.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/services/language_delegate.dart';
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
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => MovieBloc(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          const TranslationsDelegate(),
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('id', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
                supportedLocaleLanguage.countryCode == locale.countryCode) {
              return supportedLocaleLanguage;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        routes: AppRoutes().getRoutes,
        initialRoute: AppRoutes.splashScreen,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: ColorsApp.blueMtix,
          ),
          colorScheme: const ColorScheme.light(
            background: ColorsApp.backgroundDashboardColor,
          ),
        ),
      ),
    );
  }
}
