import 'package:flutter/material.dart';
import 'package:my_manager/models/order.dart';
import 'package:my_manager/screens/order/components/ordered_sari_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total=0;
    for (var e in order.sari) {
      total+=e.quantity*e.unitPrice;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide()),
      ),
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
          const SizedBox(height: 8),
          ...order.sari.map((e) => OrderedSariTile(orderedSari: e)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.only(right: 12),
            alignment: Alignment.centerRight,
            child: Text("মোটঃ $total"),
          )
        ],
      ),
    );
  }
}
