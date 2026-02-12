import 'package:test_app/src/features/movies/data/models/movie_detail_model.dart';
import 'package:test_app/src/features/movies/domain/entities/video_entity.dart';
import 'package:test_app/src/features/movies/domain/entities/image_entity.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailModel movie;
  final List<VideoEntity> videos;
  final List<ImageEntity> images;

  MovieDetailLoaded({
    required this.movie,
    required this.videos,
    required this.images,
  });
}

class MovieDetailError extends MovieDetailState {
  final String message;
  MovieDetailError({required this.message});
}
