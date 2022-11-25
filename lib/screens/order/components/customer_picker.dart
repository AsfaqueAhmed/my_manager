import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/screens/customer/controllers/customer_controller.dart';
import 'package:my_manager/widget/text_input_widget.dart';

class CustomerPicker extends StatefulWidget {
  final Customer? customer;

  const CustomerPicker({
    Key? key,
    this.customer,
  }) : super(key: key);

  @override
  State<CustomerPicker> createState() => _CustomerPickerState();
}

class _CustomerPickerState extends State<CustomerPicker> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.25,
                ))),
            child: Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8.0,
            ),
            child: TextInputWidget(
              hint: "কাস্টমার নাম",
              controller: textEditingController,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.25, color: Colors.grey))),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: const Text(
              "কাস্টময়ার তালিকা",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: buildCustomerList(),
          ),
        ],
      ),
    );
  }

  Obx buildCustomerList() {
    return Obx(() {
      List<Customer> customers =
          Get.find<CustomerController>().customerList.value ?? [];
      return ValueListenableBuilder<TextEditingValue>(
          valueListenable: textEditingController,
          builder: (context, value, child) {
            return Column(
              children: [
                if (value.text.isEmpty)
                  const SizedBox()
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _memberTile(
                        title: value.text,
                        onTap: () => Get.back(result: value.text)),
                  ),
                Expanded(
                  child: Builder(builder: (context) {
                    List<Customer> filteredCustomers = customers
                        .where((element) => element.name
                            .toLowerCase()
                            .contains(value.text.toLowerCase()))
                        .toList();
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemBuilder: (context, index) => _memberTile(
                          title: filteredCustomers[index].name,
                          subTitle: filteredCustomers[index].mobileNumber,
                          onTap: () =>
                              Get.back(result: filteredCustomers[index])),
                      itemCount: filteredCustomers.length,
                    );
                  }),
                ),
              ],
            );
          });
    });
  }

  Widget _memberTile(
      {required String title, String? subTitle, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey,
          width: 0.25,
        ))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            if (subTitle != null)
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
