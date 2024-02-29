import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  late SharedPreferences pref;

  markFavoriteMovie(String movieId, bool status) async {
    pref = await SharedPreferences.getInstance();
    pref.setBool(movieId, status);
  }

  Future<bool> getFavoriteMovie(String movieId) async {
    pref = await SharedPreferences.getInstance();
    bool boolValue = pref.getBool(movieId) ?? false;
    return boolValue;
  }

  Future<List<String>> getAllFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final List<String> prefsMap2 = [];

    for (String key in keys) {
      if (prefs.get(key) == true) {
        prefsMap2.add(key);
      }
    }
    prefsMap2.sort();

    return prefsMap2;
  }
}
