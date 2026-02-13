import 'package:test_app/src/features/movies/data/models/movie_model.dart';

class SearchMoviesResponse {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  SearchMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchMoviesResponse.fromJson(Map<String, dynamic> json) {
    return SearchMoviesResponse(
      page: json['page'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((m) => MovieModel.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] ?? 0,
      totalResults: json['total_results'] ?? 0,
    );
  }
}
