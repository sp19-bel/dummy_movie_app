import 'package:test_app/src/features/home/domain/entities/entities.dart';

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
      posterPath: json['poster_Path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble,
    );
  }
}
