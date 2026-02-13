import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:test_app/src/core/config/flavors/flavor_config.dart';
import 'package:test_app/src/data_sources/api_client.dart';
import 'package:test_app/src/data_sources/network/dio_session.dart';

import 'package:test_app/src/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:test_app/src/features/movies/data/repositories/movies_repository.dart';
import 'package:test_app/src/features/movies/domain/protocols/movies_repository_protocol.dart';
import 'package:test_app/src/features/movies/domain/use_cases/get_upcoming_movies.dart';
import 'package:test_app/src/features/movies/domain/use_cases/get_movie_details.dart';
import 'package:test_app/src/features/movies/domain/use_cases/get_movie_images.dart';
import 'package:test_app/src/features/movies/domain/use_cases/get_movie_videos.dart';
import 'package:test_app/src/features/movies/domain/use_cases/search_movies.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_list_cubit.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_detail_cubit.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_search_cubit.dart';

import 'package:test_app/src/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:test_app/src/features/home/data/repositories/home_repository.dart';
import 'package:test_app/src/features/home/domain/protocols/home_repository_protocol.dart';
import 'package:test_app/src/features/home/domain/use_cases/get_upcoming_movies_usecase.dart';
import 'package:test_app/src/features/home/presentation/cubit/home_cubit.dart';

final di = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  di.registerFactory<ApiClient>(
    () => ApiClient(flavor: FlavorConfig.shared.flavor),
  );

  di.registerLazySingleton<Dio>(() => Dio());

  di.registerFactory<DioSession>(() => DioSession(client: di()));

  // Data Sources
  di.registerFactory<MoviesRemoteDataSource>(() => MoviesRemoteDataSource());

  // Repositories
  di.registerFactory<MoviesRepositoryProtocol>(
    () => MoviesRepository(remoteDataSource: di()),
  );

  // Use Cases
  di.registerFactory<GetUpcomingMovies>(
    () => GetUpcomingMovies(repository: di()),
  );
  di.registerFactory<GetMovieDetails>(
    () => GetMovieDetails(repository: di()),
  );
  di.registerFactory<GetMovieImages>(
    () => GetMovieImages(repository: di()),
  );
  di.registerFactory<GetMovieVideos>(
    () => GetMovieVideos(repository: di()),
  );
  di.registerFactory<SearchMovies>(
    () => SearchMovies(repository: di()),
  );

  // Cubits
  di.registerFactory<MovieListCubit>(
    () => MovieListCubit(getUpcomingMovies: di()),
  );
  di.registerFactory<MovieDetailCubit>(
    () => MovieDetailCubit(
      getMovieDetails: di(),
      getMovieVideos: di(),
      getMovieImages: di(),
    ),
  );
  di.registerFactory<MovieSearchCubit>(
    () => MovieSearchCubit(searchMovies: di()),
  );

  // Home Feature
  di.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSource());
  di.registerLazySingleton<HomeRepositoryProtocol>(
    () => HomeRepository(remoteDataSource: di()),
  );
  di.registerFactory<GetUpcomingMoviesUseCase>(
    () => GetUpcomingMoviesUseCase(repository: di()),
  );
  di.registerFactory<HomeCubit>(
    () => HomeCubit(getUpcomingMoviesUseCase: di()),
  );
}
