import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileUploadSnackBar extends StatelessWidget {
  final RxString title;
  final RxInt progress;

  const FileUploadSnackBar({
    Key? key,
    required this.title,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static show({
    required RxString title,
    required RxInt progress,
  }) {

  }
}
