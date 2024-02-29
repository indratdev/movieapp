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

//////
class FailureMovieByTitle extends FailureMovieState {
  FailureMovieByTitle({required super.info});
}

class LoadingMovieByTitle extends MovieState {}

class SuccessMovieByTitle extends MovieState {
  MovieResponseModel result;

  SuccessMovieByTitle({
    required this.result,
  });

  List<Object> get props => [result];
}

///
class FailureMovieDetail extends FailureMovieState {
  FailureMovieDetail({required super.info});
}

class LoadingMovieDetail extends MovieState {}

class SuccessMovieDetail extends MovieState {
  MovieDetailResponseModel result;

  SuccessMovieDetail({
    required this.result,
  });

  List<Object> get props => [result];
}

// favorite movie

class LoadingSetUnsetFavoriteMovie extends MovieState {}

class SuccessGetFavoriteMovie extends MovieState {
  bool isFavorite;

  SuccessGetFavoriteMovie({
    required this.isFavorite,
  });

  @override
  List<Object> get props => [isFavorite];
}

class SuccessSetUnsetFavoriteMovie extends MovieState {
  bool isFavorite;
  String status;

  SuccessSetUnsetFavoriteMovie({
    required this.isFavorite,
    required this.status,
  });

  @override
  List<Object> get props => [isFavorite, status];
}

class FailureSetUnsetFavoriteMovie extends MovieState {
  String messageError;

  FailureSetUnsetFavoriteMovie({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

//////////////// favorite surah list
class LoadingListSurahFavorite extends MovieState {}

class FailureListSurahFavorite extends MovieState {
  String messageError;

  FailureListSurahFavorite({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class SuccessListSurahFavorite extends MovieState {
  List<Search> result;

  SuccessListSurahFavorite({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

// end favorite movie

class FailureGetAllFavorite extends FailureMovieState {
  FailureGetAllFavorite({required super.info});
}

class LoadingGetAllFavorite extends MovieState {}

class SuccessGetAllFavorite extends MovieState {
  List<MovieDetailResponseModel> result;

  SuccessGetAllFavorite({
    required this.result,
  });

  List<Object> get props => [result];
}
