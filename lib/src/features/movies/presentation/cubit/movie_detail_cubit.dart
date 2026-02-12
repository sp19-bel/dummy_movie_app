import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_app/src/features/movies/domain/entities/video_entity.dart';
import 'package:test_app/src/features/movies/domain/entities/image_entity.dart';
import 'package:test_app/src/features/movies/domain/use_cases/get_movie_details.dart';
import 'package:test_app/src/features/movies/domain/use_cases/get_movie_images.dart';
import 'package:test_app/src/features/movies/domain/use_cases/get_movie_videos.dart';
import 'package:test_app/src/features/movies/presentation/cubit/movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetails getMovieDetails;
  final GetMovieVideos getMovieVideos;
  final GetMovieImages getMovieImages;

  MovieDetailCubit({
    required this.getMovieDetails,
    required this.getMovieVideos,
    required this.getMovieImages,
  }) : super(MovieDetailInitial());

  Future<void> fetchMovieDetail({required int movieId}) async {
    emit(MovieDetailLoading());

    final detailResult = await getMovieDetails(movieId: movieId);

    await detailResult.fold(
      (failure) async =>
          emit(MovieDetailError(message: failure.toString())),
      (movie) async {
        final videosResult = await getMovieVideos(movieId: movieId);
        final imagesResult = await getMovieImages(movieId: movieId);

        final videos = videosResult.fold((_) => <VideoEntity>[], (r) => r.results);
        final images = imagesResult.fold((_) => <ImageEntity>[], (r) => r.backdrops);

        emit(MovieDetailLoaded(
          movie: movie,
          videos: videos,
          images: images,
        ));
      },
    );
  }
}
