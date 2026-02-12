import 'package:test_app/src/features/movies/data/models/movie_model.dart';

abstract class MovieListState {}

class MovieListInitial extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListLoaded extends MovieListState {
  final List<MovieModel> movies;
  final int currentPage;
  final int totalPages;

  MovieListLoaded({
    required this.movies,
    required this.currentPage,
    required this.totalPages,
  });
}

class MovieListError extends MovieListState {
  final String message;
  MovieListError({required this.message});
}
