import 'package:dartz/dartz.dart';

import 'package:test_app/src/core/utils/exception_mixin.dart';
import 'package:test_app/src/data_sources/network/dio_session.dart';
import 'package:test_app/src/features/movies/data/models/exchange/movie_images_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/movie_videos_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/search_movies_response.dart';
import 'package:test_app/src/features/movies/data/models/exchange/upcoming_movies_response.dart';
import 'package:test_app/src/features/movies/data/models/movie_detail_model.dart';
import 'package:test_app/src/features/movies/data/services/movie_details_service.dart';
import 'package:test_app/src/features/movies/data/services/movie_images_service.dart';
import 'package:test_app/src/features/movies/data/services/movie_videos_service.dart';
import 'package:test_app/src/features/movies/data/services/search_movies_service.dart';
import 'package:test_app/src/features/movies/data/services/upcoming_movies_service.dart';
import 'package:test_app/src/injection.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class MoviesRemoteDataSource with ExceptionMixin {
  Future<Either<GeneralException, UpcomingMoviesResponse>> getUpcomingMovies({
    int page = 1,
  }) async {
    return await handleResponse(
      () async => await di<DioSession>().request(
        service: UpcomingMoviesService(page: page),
        fromJson: UpcomingMoviesResponse.fromJson,
      ),
    );
  }

  Future<Either<GeneralException, MovieDetailModel>> getMovieDetails({
    required int movieId,
  }) async {
    return await handleResponse(
      () async => await di<DioSession>().request(
        service: MovieDetailsService(movieId: movieId),
        fromJson: MovieDetailModel.fromJson,
      ),
    );
  }

  Future<Either<GeneralException, MovieImagesResponse>> getMovieImages({
    required int movieId,
  }) async {
    return await handleResponse(
      () async => await di<DioSession>().request(
        service: MovieImagesService(movieId: movieId),
        fromJson: MovieImagesResponse.fromJson,
      ),
    );
  }

  Future<Either<GeneralException, MovieVideosResponse>> getMovieVideos({
    required int movieId,
  }) async {
    return await handleResponse(
      () async => await di<DioSession>().request(
        service: MovieVideosService(movieId: movieId),
        fromJson: MovieVideosResponse.fromJson,
      ),
    );
  }

  Future<Either<GeneralException, SearchMoviesResponse>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    return await handleResponse(
      () async => await di<DioSession>().request(
        service: SearchMoviesService(query: query, page: page),
        fromJson: SearchMoviesResponse.fromJson,
      ),
    );
  }
}
