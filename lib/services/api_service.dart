import 'dart:convert';

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_app/models/responses/movie_detail_response_model.dart';
import 'package:movie_app/models/responses/movie_response_model.dart';
import 'package:movie_app/shared/global_variables.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = "https://www.omdbapi.com/";
  String apiKeyApp = "?apikey=${GlobalVariables.apiKey}";
  final generalMovie = "&s=movie&type=movie&y=2023";

  var queryParameters = {
    'apikey': GlobalVariables.apiKey,
  };

  var headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  String getParamMovie(String? title,
      {required bool isDetail, String idMovie = ""}) {
    String result = "";

    switch (isDetail) {
      case true:
        result = "&i=$idMovie";
        break;

      case false:
        if (title == null) {
          result = "&s=movie&type=movie&y=2023";
        } else {
          result = "&s=$title&type=movie&y=2023";
        }
        break;
      default:
    }
    return result;
  }

  Future<Either<String, MovieResponseModel>> getRandomMovie() async {
    try {
      String paramMovie = getParamMovie(null, isDetail: false);
      final response =
          await http.get(Uri.parse("$baseUrl$apiKeyApp$paramMovie"));

      if (response.statusCode == 200) {
        final item = jsonDecode(response.body);

        return Right(MovieResponseModel.fromMap(item));
      } else {
        return Left("Error");
      }
    } catch (e) {
      return Left("Error");
    }
  }

  Future<Either<String, MovieResponseModel>> getMovieByTitle(
      String title) async {
    try {
      String paramMovie = getParamMovie(title, isDetail: false);
      final response =
          await http.get(Uri.parse("$baseUrl$apiKeyApp$paramMovie"));

      if (response.statusCode == 200) {
        final item = jsonDecode(response.body);

        return Right(MovieResponseModel.fromMap(item));
      } else {
        return Left("Error");
      }
    } catch (e) {
      return Left("Error");
    }
  }

  Future<Either<String, MovieDetailResponseModel>> getMovieByIdMovie(
      String idMovie) async {
    try {
      String paramMovie = getParamMovie(null, isDetail: true, idMovie: idMovie);
      final response =
          await http.get(Uri.parse("$baseUrl$apiKeyApp$paramMovie"));

      if (response.statusCode == 200) {
        final item = jsonDecode(response.body);

        return Right(MovieDetailResponseModel.fromJson(item));
      } else {
        return Left("Error");
      }
    } catch (e) {
      return Left("Error");
    }
  }
}
