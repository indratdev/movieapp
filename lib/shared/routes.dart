
import 'package:flutter/material.dart';
import 'package:movie_app/views/login/login_screen.dart';
import 'package:movie_app/views/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash';
  static const String loginScreen = '/login';
  // static const String dashboardScreen = '/dashboard';
  // static const String playingScreen = '/playing';
  // static const String detailPlayingScreen = '/playing/detail';
  // static const String theaterScreen = '/theater';
  // static const String theaterDetailScreen = '/theater/detail';
  // static const String theaterLocationScreen = '/theater/location';
  // static const String mfoodOrder = '/mfood/order';

  Map<String, WidgetBuilder> getRoutes = {
    splashScreen: (_) => SplashScreen(),
    loginScreen: (_) => LoginScreen(),
    // dashboardScreen: (_) => DashboardScreen(),
    // playingScreen: (_) => PlayingScreen(),
    // detailPlayingScreen: (_) => DetailPlayingScreen(),
    // theaterScreen: (_) => TheaterScreen(),
    // theaterLocationScreen: (_) => TheaterLocationScreen(),
    // mfoodOrder: (_) => MfoodOrderScreen(),
    // theaterDetailScreen: (_) => TheaterDetailScreen(),
  };
}
