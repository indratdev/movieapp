import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/responses/movie_detail_response_model.dart';
import 'package:movie_app/models/responses/movie_response_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/services/shared_preferences.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    ApiService apiService = ApiService();
    final pref = MySharedPref();

    on<MovieInitEvent>((event, emit) {
      emit(MovieInitial());
    });

    on<GetRandomMovie>((event, emit) async {
      emit(LoadingRandomMovie());
      try {
        Either<String, MovieResponseModel> result =
            await apiService.getRandomMovie();

        result.fold(
          (l) => emit(FailureRandomMovie(info: l.toString())),
          (data) => emit(SuccessRandomMovie(result: data)),
        );
      } catch (e) {
        emit(FailureRandomMovie(info: e.toString()));
      }
    });

    on<GetMovieByTitle>((event, emit) async {
      emit(LoadingMovieByTitle());
      try {
        Either<String, MovieResponseModel> result =
            await apiService.getMovieByTitle(event.title);

        result.fold(
          (l) => emit(FailureMovieByTitle(info: l.toString())),
          (data) => emit(SuccessMovieByTitle(result: data)),
        );
      } catch (e) {
        emit(FailureMovieByTitle(info: e.toString()));
      }
    });

    on<GetMovieDetail>((event, emit) async {
      emit(LoadingMovieDetail());
      try {
        Either<String, MovieDetailResponseModel> result =
            await apiService.getMovieByIdMovie(event.idMovie);

        result.fold(
          (l) => emit(FailureMovieDetail(info: l.toString())),
          (data) => emit(SuccessMovieDetail(result: data)),
        );
      } catch (e) {
        emit(FailureMovieDetail(info: e.toString()));
      }
    });

    // favorite
    on<GetFavoriteMovieEvent>((event, emit) async {
      try {
        var result = await pref.getFavoriteMovie(event.movieId);
        emit(SuccessGetFavoriteMovie(isFavorite: result));
      } catch (e) {
        log(e.toString());
      }
    });
    on<SetFavoriteMovieEvent>((event, emit) async {
      try {
        emit(LoadingSetUnsetFavoriteMovie());
        await pref.markFavoriteMovie(event.movieId, event.status);

        String status = (event.status)
            ? "Success Mark Movie Favorite"
            : "Success Remark Movie";

        emit(SuccessSetUnsetFavoriteMovie(
            isFavorite: event.status, status: status));
      } catch (e) {
        emit(FailureSetUnsetFavoriteMovie(
            messageError: "Error: Failed to mark movie"));
      }
    });

    on<GetAllFavoriteEvent>((event, emit) async {
      emit(LoadingGetAllFavorite());
      try {
        List<MovieDetailResponseModel> listResult = [];
        List<String> listMovieId = await pref.getAllFavorite();
        for (var element in listMovieId) {
          Either<String, MovieDetailResponseModel> result =
              await apiService.getMovieByIdMovie(element);
          result.fold(
            (l) => null,
            (data) {
              listResult.add(data);
            },
          );
        }
        emit(SuccessGetAllFavorite(result: listResult));
      } catch (e) {
        emit(FailureGetAllFavorite(info: e.toString()));
      }
    });
  }
}
