import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String? title;

  const EmptyList({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.playlist_remove,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(title ?? "কোন ডাটা নাই")
        ],
      ),
    );
  }
}
