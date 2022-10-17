import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_type_controller.dart';

class AddTypeView extends GetView<AddTypeController> {
  const AddTypeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTypeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddTypeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
