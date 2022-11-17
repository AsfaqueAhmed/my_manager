import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/supply_controller.dart';

class SupplyView extends StatelessWidget {
  final SupplyController controller = Get.put(SupplyController());

  SupplyView({Key? key}) : super(key: key);

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
        'নতুন সাপ্লায়',
      ),
      icon: const Icon(Icons.add),
    );
  }
}
