import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:my_manager/services/customer_service.dart';
import 'package:my_manager/services/supplier_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditSupplierController extends GetxController {
  late TextEditingController nameController,
      numberController,
      addressController,
      detailsController;

  late List<XFile> images = [];

  Supplier? supplier = Get.arguments;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController(text: supplier?.name);
    numberController = TextEditingController(text: supplier?.mobileNumber);
    detailsController = TextEditingController(text: supplier?.details);
    addressController = TextEditingController(text: supplier?.address);
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    detailsController.dispose();
    addressController.dispose();
    super.dispose();
  }

  save() async {
    if (nameController.text.isEmpty ||
        numberController.text.isEmpty ||
        detailsController.text.isEmpty ||
        addressController.text.isEmpty) return;
    try {
      Loading.show();
      await SupplierService().addSupplier(Supplier(
        name: nameController.text,
        mobileNumber: numberController.text,
        details: detailsController.text,
        address: addressController.text,
      ));
      Loading.hide();
      Get.back();
    } catch (error) {
      Loading.hide();
      Toaster.error(error.toString());
    }
  }
}

