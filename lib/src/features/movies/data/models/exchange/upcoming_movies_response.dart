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
    final resultsList = json['results'];
    final List<MovieModel> movies = [];
    
    if (resultsList is List) {
      for (var item in resultsList) {
        if (item is Map) {
          movies.add(MovieModel.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }
    
    return UpcomingMoviesResponse(
      page: json['page'] is int ? json['page'] as int : 0,
      results: movies,
      totalPages: json['total_pages'] is int ? json['total_pages'] as int : 0,
      totalResults: json['total_results'] is int ? json['total_results'] as int : 0,
    );
  }
}
