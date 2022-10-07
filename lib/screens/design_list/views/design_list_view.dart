import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/design_list_controller.dart';

class DesignListView extends GetView<DesignListController> {
  const DesignListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DesignListView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DesignListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
