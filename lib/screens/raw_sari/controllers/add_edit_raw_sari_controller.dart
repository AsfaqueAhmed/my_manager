import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/raw_sari.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:my_manager/services/customer_service.dart';
import 'package:my_manager/services/supplier_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditRawSariController extends GetxController {
  late TextEditingController titleController,
      colorController,
      materialController,
      buyingProce;

  late List<XFile> images = [];

  Rx<Supplier?> supplier = Rx<Supplier?>(null);
  RawSari? rawSari = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: rawSari?.title);
    colorController = TextEditingController(text: rawSari?.color);
    buyingProce = TextEditingController(text: rawSari?.details);
    materialController = TextEditingController(text: rawSari?.material);
  }

  @override
  void dispose() {
    titleController.dispose();
    colorController.dispose();
    buyingProce.dispose();
    materialController.dispose();
    super.dispose();
  }

  save() async {
    if (titleController.text.isEmpty ||
        colorController.text.isEmpty ||
        buyingProce.text.isEmpty ||
        materialController.text.isEmpty) return;
    try {
      Loading.show();
      await SupplierService().addSupplier(Supplier(
        name: titleController.text,
        mobileNumber: colorController.text,
        details: buyingProce.text,
        address: materialController.text,
      ));
      Loading.hide();
      Get.back();
    } catch (error) {
      Loading.hide();
      Toaster.error(error.toString());
    }
  }
}