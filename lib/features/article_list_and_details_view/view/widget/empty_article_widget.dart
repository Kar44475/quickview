import 'package:flutter/material.dart';
class EmptyArticlesWidget extends StatelessWidget {
  const EmptyArticlesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No articles found'),
        ],
      ),
    );
  }
}