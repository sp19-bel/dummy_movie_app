import 'package:test_app/src/features/home/domain/entities/upcoming_movie_entity.dart';

class UpcomingMovieModel extends UpcomingMovieEntity {
  UpcomingMovieModel({
    required super.id,
    required super.title,
    required super.posterPath,
    required super.releaseDate,
    required super.voteAverage,
  });

  factory UpcomingMovieModel.fromJson(Map<String, dynamic> json) {
    return UpcomingMovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
