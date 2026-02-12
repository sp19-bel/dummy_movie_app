import 'package:dartz/dartz.dart';

import 'package:test_app/src/features/movies/data/models/exchange/search_movies_response.dart';
import 'package:test_app/src/features/movies/domain/protocols/movies_repository_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class SearchMovies {
  final MoviesRepositoryProtocol repository;

  SearchMovies({required this.repository});

  Future<Either<GeneralException, SearchMoviesResponse>> call({
    required String query,
    int page = 1,
  }) {
    return repository.searchMovies(query: query, page: page);
  }
}
