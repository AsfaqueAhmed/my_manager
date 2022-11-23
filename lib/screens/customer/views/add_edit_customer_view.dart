import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/customer/controllers/add_edit_customer_controller.dart';
import 'package:my_manager/widget/custom_button.dart';
import 'package:my_manager/widget/text_input_widget.dart';

class AddEditCustomerView extends StatelessWidget {
  final AddEditCustomerController controller =
      Get.put(AddEditCustomerController());

  AddEditCustomerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("নতুন কাস্টমার"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          TextInputWidget(
            hint: "নাম",
            controller: controller.nameController,
          ),
          const SizedBox(height: 20),
          TextInputWidget(
            hint: "নাম্বার",
            controller: controller.numberController,
          ),
          const SizedBox(height: 20),
          TextInputWidget(
            hint: "ঠিকানা",
            controller: controller.addressController,
          ),
          const SizedBox(height: 20),
          TextInputWidget(
            hint: "বিবরণ",
            controller: controller.detailsController,
          ),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: controller.save,
            buttonText: "কাস্টমার যোগ করুন",
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
