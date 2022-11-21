import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:my_manager/screens/raw_sari/controllers/add_edit_raw_sari_controller.dart';
import 'package:my_manager/screens/supplier/controllers/supplier_controller.dart';
import 'package:my_manager/widget/custom_buttom.dart';
import 'package:my_manager/widget/dropdown_input_area.dart';
import 'package:my_manager/widget/text_input_widget.dart';

class AddEditRawSariView extends StatelessWidget {
  final AddEditRawSariController controller =
      Get.put(AddEditRawSariController());
  final supplierController = Get.find<SupplierController>();

  AddEditRawSariView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("নতুন এক কালার শাড়ি"),
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
            hint: "টাইটেল",
            controller: controller.titleController,
          ),
          const SizedBox(height: 20),
          TextInputWidget(
            hint: "রং",
            controller: controller.colorController,
          ),
          const SizedBox(height: 20),
          TextInputWidget(
            hint: "ম্যাটেরিয়াল",
            controller: controller.materialController,
          ),
          const SizedBox(height: 20),
          TextInputWidget(
            hint: "দাম",
            controller: controller.buyingProce,
          ),
          const SizedBox(height: 20),
          Obx(
            () {
              return DropDownInputArea<Supplier>(
                title: "সাপ্লায়ার",
                selectedItem: controller.supplier.value,
                items: supplierController.supplierList.value ?? [],
                onSelect: controller.supplier,
                getId: (item) => item.id,
                getTitle: (item) => item.name,
                getSubString: (item) => "${item.mobileNumber}",
              );
            },
          ),
          const SizedBox(height: 32),
          CustomButton(
            onPressed: controller.save,
            buttonText: "শাড়ি যোগ করুন",
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
