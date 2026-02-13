import 'package:dartz/dartz.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';
import 'package:test_app/src/features/home/domain/entities/upcoming_movie_entity.dart';

abstract class HomeRepositoryProtocol {
  Future<Either<GeneralException, List<UpcomingMovieEntity>>> getUpcomingMovies();
}