import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/widgets/app_top_bar.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppTopBar(
            title: 'Add Product',
            enableBack: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                //Expanded(child: child),
              ],
            ),
          ),
          Expanded(
            child: ListView(),
          ),
        ],
      ),
    );
  }
}
