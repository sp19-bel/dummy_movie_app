import 'package:dartz/dartz.dart';
import 'package:test_app/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:test_app/src/features/home/domain/entities/upcoming_movie_entity.dart';
import 'package:test_app/src/features/home/domain/protocols/home_repository_protocol.dart';
import 'package:test_app/src/shared/protocols/general_exception.dart';

class HomeRepository implements HomeRepositoryProtocol {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepository({required this.remoteDataSource});

  @override
  Future<Either<GeneralException, List<UpcomingMovieEntity>>>
      getUpcomingMovies() async {
    final result = await remoteDataSource.getUpcomingMovies();
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response.results),
    );
  }

  @override
  Future<Either<GeneralException, List<UpcomingMovieEntity>>>
      getMoviesByGenre(String genre) async {
    final result = await remoteDataSource.getMoviesByGenre(genre);
    return result.fold(
      (failure) => Left(failure),
      (response) => Right(response.results),
    );
  }
}
