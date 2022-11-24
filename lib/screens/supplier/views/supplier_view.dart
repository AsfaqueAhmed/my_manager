import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/supplier/component/supplier_tile.dart';
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
          itemBuilder: (context, index) => SupplierTile(
            supplierList: supplierList[index],
          ),
          itemCount: supplierList.length,
        );
      }),
    );
  }
}
