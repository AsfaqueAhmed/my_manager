import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/supplier_controller.dart';

class AddEditSupplierView extends StatelessWidget {
  final SupplierController controller = Get.put(SupplierController());

  AddEditSupplierView({Key? key}) : super(key: key);

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
        'নতুন অর্ডার',
      ),
      icon: const Icon(Icons.add),
    );
  }
}