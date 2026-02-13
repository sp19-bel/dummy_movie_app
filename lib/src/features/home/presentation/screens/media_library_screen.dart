import 'package:flutter/material.dart';
import 'package:test_app/src/core/config/theme/app_colors.dart';

class MediaLibraryScreen extends StatelessWidget {
  const MediaLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Library'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.video_library_outlined, size: 80, color: AppColors.textGrey),
            SizedBox(height: 16),
            Text(
              'Media Library',
              style: TextStyle(fontSize: 20, color: AppColors.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}
