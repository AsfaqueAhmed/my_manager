import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/supplier/controllers/add_edit_supplier_controller.dart';
import 'package:my_manager/widget/custom_buttom.dart';
import 'package:my_manager/widget/text_input_widget.dart';

class AddEditSupplierView extends StatelessWidget {
  final AddEditSupplierController controller =
      Get.put(AddEditSupplierController());

  AddEditSupplierView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("নতুন সাপ্লায়ার"),
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
            controller: controller.numberController,
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
            buttonText: "সাপ্লায়ার যোগ করুন",
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
