import 'package:test_app/src/features/movies/data/models/movie_model.dart';

abstract class MovieSearchState {}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<MovieModel> movies;

  MovieSearchLoaded({required this.movies});
}

class MovieSearchError extends MovieSearchState {
  final String message;
  MovieSearchError({required this.message});
}
