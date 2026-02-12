import 'package:dartz/dartz.dart';

import 'package:test_app/src/features/movies/data/models/exchange/movie_images_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/movie_videos_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/search_movies_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/upcoming_movies_response.dart';
import 'package:test_app/src/features/movies/data/models/movie_detail_model.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

abstract class MoviesRepositoryProtocol {
  Future<Either<GeneralException, UpcomingMoviesResponse>> getUpcomingMovies({
    int page = 1,
  });

  Future<Either<GeneralException, MovieDetailModel>> getMovieDetails({
    required int movieId,
  });

  Future<Either<GeneralException, MovieImagesResponse>> getMovieImages({
    required int movieId,
  });

  Future<Either<GeneralException, MovieVideosResponse>> getMovieVideos({
    required int movieId,
  });

  Future<Either<GeneralException, SearchMoviesResponse>> searchMovies({
    required String query,
    int page = 1,
  });
}
