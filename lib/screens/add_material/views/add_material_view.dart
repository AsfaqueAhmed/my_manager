import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_material_controller.dart';

class AddMaterialView extends GetView<AddMaterialController> {
  const AddMaterialView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddMaterialView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddMaterialView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
