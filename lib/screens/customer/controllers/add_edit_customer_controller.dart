import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/services/customer_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditCustomerController extends GetxController {
  late TextEditingController nameController,
      numberController,
      addressController,
      detailsController;

  late List<XFile> images = [];

  Customer? customer = Get.arguments;

  @override
  void onInit() {
    super.onInit();

    nameController = TextEditingController(text: customer?.name);
    numberController = TextEditingController(text: customer?.mobileNumber);
    detailsController = TextEditingController(text: customer?.details);
    addressController = TextEditingController(text: customer?.address);
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
      await CustomerService().addCustomer(Customer(
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
