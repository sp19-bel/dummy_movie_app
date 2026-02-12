import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/src/features/movies/domain/use_cases/get_upcoming_movies.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  final GetUpcomingMovies getUpcomingMovies;

  MovieListCubit({required this.getUpcomingMovies})
      : super(MovieListInitial());

  Future<void> fetchUpcomingMovies({int page = 1}) async {
    emit(MovieListLoading());
    final result = await getUpcomingMovies(page: page);
    result.fold(
      (failure) => emit(MovieListError(message: failure.toString())),
      (response) => emit(MovieListLoaded(
        movies: response.results,
        currentPage: response.page,
        totalPages: response.totalPages,
      )),
    );
  }
}
