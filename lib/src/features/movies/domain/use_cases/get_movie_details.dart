import 'package:dartz/dartz.dart';

import 'package:test_app/src/features/movies/data/models/movie_detail_model.dart';
import 'package:test_app/src/features/movies/domain/protocols/movies_repository_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class GetMovieDetails {
  final MoviesRepositoryProtocol repository;

  GetMovieDetails({required this.repository});

  Future<Either<GeneralException, MovieDetailModel>> call({
    required int movieId,
  }) {
    return repository.getMovieDetails(movieId: movieId);
  }
}
