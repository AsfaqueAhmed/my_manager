import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_design_controller.dart';

class AddDesignView extends GetView<AddDesignController> {
  const AddDesignView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddDesignView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AddDesignView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
