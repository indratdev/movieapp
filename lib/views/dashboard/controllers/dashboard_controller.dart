import 'package:movie_app/models/banner_movie_model.dart';

class DashboardController {
  int _index = 0;

  final BannerMovieModel model = BannerMovieModel();

  List<String> get getBannerMovie => model.imgList;

  // setter & getter index bottom nav
  set setIndexBottomNav(int value) => _index = value;
  int get getIndexBottomNav => _index;
}
