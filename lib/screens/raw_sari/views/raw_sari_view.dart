import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/raw_sari_controller.dart';

class RawSariView extends StatelessWidget {
  final RawSariController controller = Get.put(RawSariController());

  RawSariView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'LogInView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onPressed: controller.addNew,
      label: const Text(
        'নতুন শাড়ি',
      ),
      icon: const Icon(Icons.add),
    );
  }
}
