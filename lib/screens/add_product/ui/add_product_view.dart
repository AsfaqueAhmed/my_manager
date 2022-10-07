import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/widgets/app_top_bar.dart';
import 'package:my_manager/widgets/tab_button.dart';

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
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TabButton(
                      selected: controller.entryType.value == EntryType.raw,
                      title: "এক কালার শাড়ি",
                      onTap: () => controller.changeEntryType(EntryType.raw),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TabButton(
                      selected:
                          controller.entryType.value == EntryType.designed,
                      title: "ডিজাইনড শাড়ি",
                      onTap: () =>
                          controller.changeEntryType(EntryType.designed),
                    ),
                  ),
                ],
              ),
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
