import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Obx(() {
        var orderList = controller.orderList.value;
        if (orderList == null) return const Center(child: Loading());
        if (orderList.isEmpty) {
          return const EmptyList();
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) {
            var order = orderList[index];
            return OrderTile(order: order);
          },
          itemCount: orderList.length,
        );
      }),
      floatingActionButton: _floatingActionButton(),
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
