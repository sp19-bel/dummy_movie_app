import 'package:test_app/src/features/movies/data/models/movie_model.dart';

class UpcomingMoviesResponse {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  UpcomingMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory UpcomingMoviesResponse.fromJson(Map<String, dynamic> json) {
    return UpcomingMoviesResponse(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((m) => MovieModel.fromJson(m))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}
