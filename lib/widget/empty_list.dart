import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String? title;

  const EmptyList({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.hourglass_empty),
          Text(title ?? "কোন ডাটা নাই")
        ],
      ),
    );
  }
}
