part of 'movie_bloc.dart';

@immutable
sealed class MovieEvent {}

class MovieInitEvent extends MovieEvent {}

class GetRandomMovie extends MovieEvent {}

class GetMovieByTitle extends MovieEvent {
  String title;

  GetMovieByTitle({required this.title});
}

class GetMovieDetail extends MovieEvent {
  String idMovie;

  GetMovieDetail({required this.idMovie});
}

class GetFavoriteMovieEvent extends MovieEvent {
  String movieId;

  GetFavoriteMovieEvent({
    required this.movieId,
  });
}

class SetFavoriteMovieEvent extends MovieEvent {
  String movieId;
  bool status;

  SetFavoriteMovieEvent({
    required this.movieId,
    required this.status,
  });
}

class GetAllFavoriteEvent extends MovieEvent {}
