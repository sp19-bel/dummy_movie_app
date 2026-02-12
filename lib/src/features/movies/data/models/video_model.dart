import 'package:test_app/src/features/movies/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.key,
    required super.name,
    required super.site,
    required super.type,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] ?? '',
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      site: json['site'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
