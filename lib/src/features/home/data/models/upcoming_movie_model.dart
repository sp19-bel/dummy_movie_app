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
    try {
      return UpcomingMovieModel(
        id: _parseInt(json['id']),
        title: _parseString(json['title']),
        posterPath: _parseString(json['poster_path']),
        releaseDate: _parseString(json['release_date']),
        voteAverage: _parseDouble(json['vote_average']),
      );
    } catch (e) {
      throw FormatException('Error parsing UpcomingMovieModel: $e');
    }
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static String _parseString(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
