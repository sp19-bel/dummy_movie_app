import 'package:test_app/src/features/movies/domain/entities/image_entity.dart';

class ImageModel extends ImageEntity {
  ImageModel({
    required super.filePath,
    required super.aspectRatio,
    required super.width,
    required super.height,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      filePath: json['file_path'] ?? '',
      aspectRatio: (json['aspect_ratio'] ?? 0).toDouble(),
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }
}
