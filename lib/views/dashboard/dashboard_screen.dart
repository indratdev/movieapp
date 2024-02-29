import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_app/services/language_translation.dart';
import 'package:movie_app/views/about_us_screen/about_us_screen.dart';
import 'package:movie_app/views/dashboard/controllers/dashboard_controller.dart';
import 'package:movie_app/shared/colors_app.dart';
import 'package:movie_app/views/favorite_movie/favorite_movie_screen.dart';
import 'package:movie_app/views/find_movie/find_movie_screen.dart';
import 'package:movie_app/views/list_movie/list_movie_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = DashboardController();

  loadInitail(int screenNumber) {
    switch (screenNumber) {
      case 0:
        context.read<MovieBloc>()
          ..add(GetRandomMovie())
          ..add(GetMovieByTitle(title: "war"));
        break;
      case 1:
        context.read<MovieBloc>().add(MovieInitEvent());
        break;

      case 2:
        context.read<MovieBloc>().add(GetAllFavoriteEvent());
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final _buildBody = <Widget>[
      ListViewMovieScreen(),
      const FindMovieScreen(),
      const FavoriteMovieScreen(),
      AboutUsScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: LanguageTranslation.of(context)!.value('list-movie'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: LanguageTranslation.of(context)!.value('find-movie'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: LanguageTranslation.of(context)!.value('favorite'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: LanguageTranslation.of(context)!.value('about_us'),
          ),
        ],
        selectedItemColor: ColorsApp.blueMtix,
        unselectedItemColor: ColorsApp.blueMtix.withOpacity(.2),
        showUnselectedLabels: true,
        currentIndex: controller.getIndexBottomNav,
        onTap: (value) {
          controller.setIndexBottomNav = value;
          loadInitail(value);
          setState(() {});
        },
      ),
      body: _buildBody[controller.getIndexBottomNav],
    );
  }
}
