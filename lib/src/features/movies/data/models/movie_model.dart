import 'package:test_app/src/features/movies/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.releaseDate,
    required super.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: _parseInt(json['id']),
      title: _parseString(json['title']),
      overview: _parseString(json['overview']),
      posterPath: _parseNullableString(json['poster_path']),
      backdropPath: _parseNullableString(json['backdrop_path']),
      voteAverage: _parseDouble(json['vote_average']),
      releaseDate: _parseString(json['release_date']),
      genreIds: _parseIntList(json['genre_ids']),
    );
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

  static String? _parseNullableString(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static List<int> _parseIntList(dynamic value) {
    if (value == null) return [];
    if (value is! List) return [];
    return value
        .map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
        .toList();
  }
}
