import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/type_list_controller.dart';

class TypeListView extends GetView<TypeListController> {
  const TypeListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TypeListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TypeListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
