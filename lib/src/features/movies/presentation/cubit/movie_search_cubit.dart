import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/src/features/movies/domain/use_cases/search_movies.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchCubit({required this.searchMovies})
      : super(MovieSearchInitial());

  Timer? _debounceTimer;
  String? _lastQuery;
  bool _isSearching = false;

  Future<void> search({required String query}) async {
    _debounceTimer?.cancel();

    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      _lastQuery = null;
      if (!isClosed) {
        emit(MovieSearchInitial());
      }
      return;
    }

    if (!isClosed) {
      emit(MovieSearchLoading());
    }

    _debounceTimer = Timer(const Duration(milliseconds: 800), () async {
      if (_lastQuery == trimmedQuery) {
        return;
      }
      await _executeSearch(trimmedQuery);
    });
  }

  Future<void> _executeSearch(String query) async {
    if (_isSearching) {
      return;
    }

    _isSearching = true;
    _lastQuery = query;

    try {
      final result = await searchMovies(query: query);

      if (isClosed) {
        return;
      }

      result.fold(
        (failure) {
          if (!isClosed) {
            emit(MovieSearchError(message: failure.message ?? 'Search failed'));
          }
        },
        (response) {
          if (!isClosed) {
            emit(MovieSearchLoaded(movies: response.results));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(MovieSearchError(message: 'An unexpected error occurred'));
      }
    } finally {
      _isSearching = false;
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    _lastQuery = null;
    return super.close();
  }
}
