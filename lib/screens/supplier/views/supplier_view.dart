import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/empty_list.dart';

import '../controllers/supplier_controller.dart';

class SupplierView extends StatelessWidget {
  final SupplierController controller = Get.find<SupplierController>();

  SupplierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("সাপ্লাইয়ার তালিকা"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.navigateToAddNewSupplier(),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        var supplierList = controller.supplierList.value;
        if (supplierList == null) return const Center(child: Loading());
        if (supplierList.isEmpty) {
          return const EmptyList();
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, index) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide()),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  supplierList[index].name,
                  style: const TextStyle(fontSize: 16),
                ),
                if (supplierList[index].mobileNumber != null)
                  Text(
                    supplierList[index].mobileNumber ?? "",
                    style: const TextStyle(fontSize: 12, height: 0.9),
                  ),
                if (supplierList[index].address != null)
                  Text(
                    supplierList[index].address ?? "",
                    style: const TextStyle(fontSize: 12, height: 1.5),
                  ),
              ],
            ),
          ),
          itemCount: supplierList.length,
        );
      }),
    );
  }
}
