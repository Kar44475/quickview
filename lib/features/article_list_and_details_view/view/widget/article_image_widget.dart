import 'package:flutter/material.dart';

class ArticleImage extends StatelessWidget {
  final String thumbnailUrl;

  const ArticleImage({super.key, required this.thumbnailUrl});

  @override
  Widget build(BuildContext context) {
    if (thumbnailUrl.isEmpty) {
      return const Icon(Icons.article);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        thumbnailUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported),
      ),
    );
  }
}