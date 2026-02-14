import 'package:test_app/src/features/home/data/models/upcoming_movie_model.dart';

class UpcomingMoviesResponse {
  final List<UpcomingMovieModel> results;

  UpcomingMoviesResponse({required this.results});

  factory UpcomingMoviesResponse.fromJson(Map<String, dynamic> json) {
    try {
      final resultsList = json['results'];
      if (resultsList == null) {
        return UpcomingMoviesResponse(results: []);
      }
      if (resultsList is! List) {
        throw FormatException(
            'Expected List for results but got ${resultsList.runtimeType}');
      }
      return UpcomingMoviesResponse(
        results: resultsList
            .map((e) {
              if (e is! Map) {
                throw FormatException(
                    'Expected Map for movie item but got ${e.runtimeType}');
              }
              return UpcomingMovieModel.fromJson(
                  Map<String, dynamic>.from(e));
            })
            .toList(),
      );
    } catch (e) {
      throw FormatException('Error parsing UpcomingMoviesResponse: $e');
    }
  }
}
