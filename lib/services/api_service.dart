import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
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

  Future<Either<String, MovieResponseModel>> getRandomMovie() async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl$apiKeyApp$generalMovie"));

      if (response.statusCode == 200) {
        final item = jsonDecode(response.body);

        return Right(MovieResponseModel.fromMap(item));
      } else {
        return Left("Error");
      }
    } catch (e) {
      print("error : $e");
      return Left("Error");
    }
  }
}
