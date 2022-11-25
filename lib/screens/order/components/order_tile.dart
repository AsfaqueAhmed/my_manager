import 'package:flutter/material.dart';
import 'package:my_manager/models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  const OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(bottom: BorderSide()),
      ),
      child: Column(
        children: [
          Text(order.customer.name),
          Text(
            order.customer.mobileNumber!,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
