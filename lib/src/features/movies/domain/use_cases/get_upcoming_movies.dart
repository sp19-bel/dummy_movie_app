import 'package:dartz/dartz.dart';

import 'package:test_app/src/features/movies/data/models/exchange/upcoming_movies_response.dart';
import 'package:test_app/src/features/movies/domain/protocols/movies_repository_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class GetUpcomingMovies {
  final MoviesRepositoryProtocol repository;

  GetUpcomingMovies({required this.repository});

  Future<Either<GeneralException, UpcomingMoviesResponse>> call({
    int page = 1,
  }) {
    return repository.getUpcomingMovies(page: page);
  }
}
