import 'package:dartz/dartz.dart';

import 'package:test_app/src/features/movies/data/models/exchange/movie_images_response.dart';
import 'package:test_app/src/features/movies/domain/protocols/movies_repository_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class GetMovieImages {
  final MoviesRepositoryProtocol repository;

  GetMovieImages({required this.repository});

  Future<Either<GeneralException, MovieImagesResponse>> call({
    required int movieId,
  }) {
    return repository.getMovieImages(movieId: movieId);
  }
}
