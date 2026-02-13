import 'package:dartz/dartz.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';
import 'package:test_app/src/features/home/domain/entities/upcoming_movie_entity.dart';
import 'package:test_app/src/features/home/domain/protocols/home_repository_protocol.dart';

class GetUpcomingMoviesUseCase {
  final HomeRepositoryProtocol repository;

  GetUpcomingMoviesUseCase({required this.repository});

  Future<Either<GeneralException, List<UpcomingMovieEntity>>> call() async {
    return await repository.getUpcomingMovies();
  }
}