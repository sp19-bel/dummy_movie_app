import 'package:dartz/dartz.dart';
import 'package:test_app/src/core/utils/exception_mixin.dart';
import 'package:test_app/src/data_sources/network/dio_session.dart';
import 'package:test_app/src/features/home/data/models/exchange/upcoming_movies_response.dart';
import 'package:test_app/src/features/home/data/services/upcoming_movies_service.dart';
import 'package:test_app/src/features/home/data/services/movies_by_genre_service.dart';
import 'package:test_app/src/injection.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class HomeRemoteDataSource with ExceptionMixin {
  Future<Either<GeneralException, UpcomingMoviesResponse>>
      getUpcomingMovies() async {
    return await handleResponse(
      () async => await di<DioSession>().request(
        service: UpcomingMoviesService(),
        fromJson: UpcomingMoviesResponse.fromJson,
      ),
    );
  }

  Future<Either<GeneralException, UpcomingMoviesResponse>>
      getMoviesByGenre(String genre) async {
    return await handleResponse(
      () async => await di<DioSession>().request(
        service: MoviesByGenreService(genre: genre),
        fromJson: UpcomingMoviesResponse.fromJson,
      ),
    );
  }
}
