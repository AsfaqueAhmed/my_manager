import 'package:flutter/material.dart';
import 'package:my_manager/models/supplier.dart';

class SupplierTile extends StatelessWidget {
  const SupplierTile({
    Key? key,
    required this.supplierList,
    this.onTap,
  }) : super(key: key);

  final Supplier supplierList;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              supplierList.name,
              style: const TextStyle(fontSize: 16),
            ),
            if (supplierList.mobileNumber != null)
              Text(
                supplierList.mobileNumber ?? "",
                style: const TextStyle(fontSize: 12, height: 0.9),
              ),
            if (supplierList.address != null)
              Text(
                supplierList.address ?? "",
                style: const TextStyle(fontSize: 12, height: 1.5),
              ),
          ],
        ),
      ),
    );
  }
}
