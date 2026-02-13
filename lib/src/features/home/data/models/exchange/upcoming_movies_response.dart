import 'package:test_app/src/features/home/data/models/upcoming_movie_model.dart';

class UpcomingMoviesResponse {
  final List<UpcomingMovieModel> results;

  UpcomingMoviesResponse({required this.results});

  factory UpcomingMoviesResponse.fromJson(Map<String, dynamic> json) {
    return UpcomingMoviesResponse(
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => UpcomingMovieModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}
