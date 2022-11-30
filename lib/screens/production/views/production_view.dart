import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/config/enums.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/screens/production/component/production_title.dart';
import 'package:my_manager/services/tab.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/empty_list.dart';

import '../controllers/production_controller.dart';

class ProductionView extends StatelessWidget {
  final ProductionController controller = Get.find<ProductionController>();

  ProductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MyTabBar<ProductionStatus>(
            selectedTab: controller.selectedTab,
            tabs: ProductionStatus.values,
            onSwitchTab: controller.switchTab,
            getTitle: (e) => e.value,
          ),
          Expanded(
            child: Obx(() {
              var productionItem = controller.productionList.value;
              if (productionItem == null) return const Center(child: Loading());
              if (productionItem.isEmpty) {
                return const EmptyList();
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12) +
                    const EdgeInsets.only(bottom: 72),
                itemBuilder: (context, index) {
                  var item = productionItem[index];
                  return ProductionTile(
                    item: item,
                    onTap: () {
                      Get.toNamed(Routes.addEditProductionItem,
                          arguments: item);
                    },
                  );
                },
                itemCount: productionItem.length,
              );
            }),
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onPressed: controller.navigateToAddProduction,
      label: const Text(
        'নতুন প্রোডাক্ট',
      ),
      icon: const Icon(Icons.add),
    );
  }
}
