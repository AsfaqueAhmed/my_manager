import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/screens/designed_sari/component/designed_raw_sari_title.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/empty_list.dart';

import '../controllers/designed_sari_controller.dart';

class DesignedSariView extends StatelessWidget {
  final DesignedSariController controller = Get.find<DesignedSariController>();

  DesignedSariView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        var designedSariList = controller.designedSariList.value;
        if (designedSariList == null) return const Center(child: Loading());
        if (designedSariList.isEmpty) {
          return const EmptyList();
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) {
            var sari = designedSariList[index];
            return DesignedSariTile(
              sari: sari,
              onTap: () {
                Get.toNamed(Routes.addEditDesignedSari, arguments: sari);
              },
            );
          },
          itemCount: designedSariList.length,
        );
      }),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onPressed: controller.navigateToAddDesignedSari,
      label: const Text(
        'নতুন পেইন্টেড শাড়ি',
      ),
      icon: const Icon(Icons.add),
    );
  }
}
