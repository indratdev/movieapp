import 'package:flutter/material.dart';
import 'package:movie_app/views/dashboard/controllers/dashboard_controller.dart';
import 'package:movie_app/shared/colors_app.dart';
import 'package:movie_app/views/list_movie/list_movie_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = DashboardController();

  @override
  Widget build(BuildContext context) {
    final _buildBody = <Widget>[
      ListViewMovieScreen(),
      Scaffold(),
      Scaffold(),
      // PlayingScreen(controller: controller),
      // UpcomingScreen(),
      // TheaterScreen(),
      // MfoodScreen(),
      // MyMtixScreen(),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset(
      //     "assets/images/splash.webp",
      //     fit: BoxFit.cover,
      //     height: MediaQuery.of(context).size.height / 7,
      //   ),
      //   centerTitle: true,
      // ),
      // drawer: DrawerDashboardWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'List Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined),
            label: 'About US',
          ),
        ],
        selectedItemColor: ColorsApp.blueMtix,
        unselectedItemColor: ColorsApp.backgroundDashboardColor,
        showUnselectedLabels: true,
        currentIndex: controller.getIndexBottomNav,
        onTap: (value) {
          controller.setIndexBottomNav = value;
          setState(() {});
        },
      ),
      body: _buildBody[controller.getIndexBottomNav],
    );
  }
}

final List<Map> myProducts =
    List.generate(20, (index) => {"id": index, "name": "Product $index"})
        .toList();
