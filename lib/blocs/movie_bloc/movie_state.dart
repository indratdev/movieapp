part of 'movie_bloc.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

class FailureMovieState extends MovieState {
  String info;

  FailureMovieState({
    required this.info,
  });

  @override
  List<Object> get props => [info];
}

// now playing
class FailureRandomMovie extends FailureMovieState {
  FailureRandomMovie({required super.info});
}

class LoadingRandomMovie extends MovieState {}

class SuccessRandomMovie extends MovieState {
  MovieResponseModel result;

  SuccessRandomMovie({
    required this.result,
  });

  List<Object> get props => [result];
}
