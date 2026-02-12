import 'package:dartz/dartz.dart';

import 'package:test_app/src/features/movies/data/models/exchange/movie_videos_response.dart';
import 'package:test_app/src/features/movies/domain/protocols/movies_repository_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class GetMovieVideos {
  final MoviesRepositoryProtocol repository;

  GetMovieVideos({required this.repository});

  Future<Either<GeneralException, MovieVideosResponse>> call({
    required int movieId,
  }) {
    return repository.getMovieVideos(movieId: movieId);
  }
}
