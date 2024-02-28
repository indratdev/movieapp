import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/responses/movie_response_model.dart';
import 'package:movie_app/services/api_service.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    ApiService apiService = ApiService();

    on<GetRandomMovie>((event, emit) async {
      emit(LoadingRandomMovie());
      try {
        print(">>> jalan");
        Either<String, MovieResponseModel> result =
            await apiService.getRandomMovie();

        result.fold(
          (l) => emit(FailureRandomMovie(info: l.toString())),
          (data) => emit(SuccessRandomMovie(result: data)),
          // (data) {
          //   print(">>> data : ${data.totalResults}");
          // },
        );
      } catch (e) {
        emit(FailureRandomMovie(info: e.toString()));
      }
    });
  }
}
