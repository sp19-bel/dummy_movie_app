import 'package:test_app/src/features/movies/data/models/image_model.dart';

class MovieImagesResponse {
  final int id;
  final List<ImageModel> backdrops;
  final List<ImageModel> posters;

  MovieImagesResponse({
    required this.id,
    required this.backdrops,
    required this.posters,
  });

  factory MovieImagesResponse.fromJson(Map<String, dynamic> json) {
    return MovieImagesResponse(
      id: json['id'] ?? 0,
      backdrops: (json['backdrops'] as List<dynamic>?)
              ?.map((i) => ImageModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      posters: (json['posters'] as List<dynamic>?)
              ?.map((i) => ImageModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
