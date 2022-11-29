import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/config/colors.dart';
import 'package:my_manager/config/enums.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/screens/order/components/order_tile.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/empty_list.dart';

import '../controllers/order_controller.dart';

class OrderView extends StatelessWidget {
  final OrderController controller = Get.put(OrderController());

  OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _tabs(),
          Expanded(
            child: Obx(() {
              var orderList = controller.orderList.value;
              if (orderList == null) return const Center(child: Loading());
              if (orderList.isEmpty) {
                return const EmptyList();
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12) +
                    const EdgeInsets.only(bottom: 80),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var order = orderList[index];
                  return OrderTile(
                    order: order,
                    onTap: () => controller.showOrderDetails(order),
                  );
                },
                itemCount: orderList.length,
              );
            }),
          ),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Obx _tabs() {
    return Obx(
      () => Row(
        children: OrderStatus.values.map((status) => _tab(status)).toList(),
      ),
    );
  }

  Expanded _tab(OrderStatus status) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.switchTab(status),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: controller.selectedTab.value == status
                    ? Get.theme.primaryColor
                    : AppColors.disable,
                width: controller.selectedTab.value == status ? 2 : 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          height: 48,
          child: Center(
              child: FittedBox(
            child: Text(
              status.value,
              style: TextStyle(
                color: controller.selectedTab.value == status
                    ? Get.theme.primaryColor
                    : AppColors.disable,
                fontWeight: controller.selectedTab.value == status
                    ? FontWeight.bold
                    : FontWeight.w200,
              ),
            ),
          )),
        ),
      ),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      onPressed: controller.navigateToAddOrder,
      label: const Text(
        'নতুন অর্ডার',
      ),
      icon: const Icon(Icons.add),
    );
  }
}
