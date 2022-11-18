import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Loading extends StatelessWidget {
  static show() => Get.dialog(const Center(child: Loading()));

  static hide() => Get.back();

  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoActivityIndicator(
      radius: 24,
    );
  }
}
