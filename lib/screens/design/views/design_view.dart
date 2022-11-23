import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/design/component/design_title.dart';
import 'package:my_manager/screens/raw_sari/component/raw_sari_title.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/empty_list.dart';

import '../controllers/design_controller.dart';

class DesignView extends StatelessWidget {
  final DesignController controller = Get.find<DesignController>();

  DesignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ডিজাইন তালিকা"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        var designList = controller.designList.value;
        if (designList == null) return const Center(child: Loading());
        if (designList.isEmpty) {
          return const EmptyList();
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) {
            var design = designList[index];
            return DesignTile(
              design: design,
              onTap: () => controller.showDesignDetails(design),
            );
          },
          itemCount: designList.length,
        );
      }),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onPressed: controller.navigateToAddDesign,
      label: const Text(
        'নতুন ডিজাইন',
      ),
      icon: const Icon(Icons.add),
    );
  }
}
