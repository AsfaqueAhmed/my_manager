import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/raw_sari/component/raw_sari_title.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/empty_list.dart';

import '../controllers/raw_sari_controller.dart';

class RawSariView extends StatelessWidget {
  final RawSariController controller = Get.find<RawSariController>();

  RawSariView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        var rawSariList = controller.rawSariList.value;
        if (rawSariList == null) return const Center(child: Loading());
        if (rawSariList.isEmpty) {
          return const EmptyList();
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12)+const EdgeInsets.only(bottom: 72),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            var sari = rawSariList[index];
            return RawSariTile(
              sari: sari,
              onTap: () => controller.showRawSariDetails(sari),
            );
          },
          itemCount: rawSariList.length,
        );
      }),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onPressed: controller.navigateToAddRawSari,
      label: const Text(
        'নতুন শাড়ি',
      ),
      icon: const Icon(Icons.add),
    );
  }
}
