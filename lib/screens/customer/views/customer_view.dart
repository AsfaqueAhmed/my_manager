import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/empty_list.dart';

import '../controllers/customer_controller.dart';

class CustomerView extends StatelessWidget {
  final CustomerController controller = Get.put(CustomerController());

  CustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("কাস্টমার তালিকা"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.navigateToAddNewCustomer(),
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        var customerList = controller.customerList.value;
        if (customerList == null) return const Center(child: Loading());
        if (customerList.isEmpty) {
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
                  customerList[index].name,
                  style: const TextStyle(fontSize: 16),
                ),
                if (customerList[index].mobileNumber != null)
                  Text(
                    customerList[index].mobileNumber ?? "",
                    style: const TextStyle(fontSize: 12, height: 0.9),
                  ),
                if (customerList[index].address != null)
                  Text(
                    customerList[index].address ?? "",
                    style: const TextStyle(fontSize: 12, height: 1.5),
                  ),
              ],
            ),
          ),
          itemCount: customerList.length,
        );
      }),
    );
  }
}
