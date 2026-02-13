import 'package:test_app/src/features/movies/data/models/video_model.dart';

class MovieVideosResponse {
  final int id;
  final List<VideoModel> results;

  MovieVideosResponse({required this.id, required this.results});

  factory MovieVideosResponse.fromJson(Map<String, dynamic> json) {
    return MovieVideosResponse(
      id: json['id'] ?? 0,
      results: (json['results'] as List<dynamic>?)
              ?.map((v) => VideoModel.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
