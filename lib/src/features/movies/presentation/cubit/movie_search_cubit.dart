import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/src/features/movies/domain/use_cases/search_movies.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchCubit({required this.searchMovies})
      : super(MovieSearchInitial());

  Future<void> search({required String query}) async {
    if (query.trim().isEmpty) {
      emit(MovieSearchInitial());
      return;
    }
    emit(MovieSearchLoading());
    final result = await searchMovies(query: query);
    result.fold(
      (failure) => emit(MovieSearchError(message: failure.toString())),
      (response) => emit(MovieSearchLoaded(movies: response.results)),
    );
  }
}
