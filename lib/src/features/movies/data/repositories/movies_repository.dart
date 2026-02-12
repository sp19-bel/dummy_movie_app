import 'package:dartz/dartz.dart';

import 'package:test_app/src/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:test_app/src/features/movies/data/models/exchange/movie_images_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/movie_videos_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/search_movies_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/upcoming_movies_response.dart';
import 'package:test_app/src/features/movies/data/models/movie_detail_model.dart';
import 'package:test_app/src/features/movies/domain/protocols/movies_repository_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class MoviesRepository implements MoviesRepositoryProtocol {
  final MoviesRemoteDataSource remoteDataSource;

  MoviesRepository({required this.remoteDataSource});

  @override
  Future<Either<GeneralException, UpcomingMoviesResponse>> getUpcomingMovies({
    int page = 1,
  }) {
    return remoteDataSource.getUpcomingMovies(page: page);
  }

  @override
  Future<Either<GeneralException, MovieDetailModel>> getMovieDetails({
    required int movieId,
  }) {
    return remoteDataSource.getMovieDetails(movieId: movieId);
  }

  @override
  Future<Either<GeneralException, MovieImagesResponse>> getMovieImages({
    required int movieId,
  }) {
    return remoteDataSource.getMovieImages(movieId: movieId);
  }

  @override
  Future<Either<GeneralException, MovieVideosResponse>> getMovieVideos({
    required int movieId,
  }) {
    return remoteDataSource.getMovieVideos(movieId: movieId);
  }

  @override
  Future<Either<GeneralException, SearchMoviesResponse>> searchMovies({
    required String query,
    int page = 1,
  }) {
    return remoteDataSource.searchMovies(query: query, page: page);
  }
}
