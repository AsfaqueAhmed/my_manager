import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/config/enums.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/models/order.dart';
import 'package:my_manager/screens/order/components/ordered_sari_tile.dart';
import 'package:my_manager/screens/order/controllers/order_controller.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final Function()? onTap;

  const OrderTile({
    Key? key,
    required this.order,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var e in order.sari) {
      total += e.quantity * e.unitPrice;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.customer.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (order.status == OrderStatus.send)
                        Text(
                          order.deliveryDate?.formattedDate ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        )
                      else
                        Text(
                          order.orderDate?.formattedDate ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.find<OrderController>()
                            .showOrderStatusChangeDialog(order);
                      },
                      child: order.status.getUi(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Text(
                        "??? $total",
                        style: const TextStyle(height: 1.5,fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...order.sari.map((e) => OrderedSariTile(orderedSari: e)),
          ],
        ),
      ),
    );
  }
}
