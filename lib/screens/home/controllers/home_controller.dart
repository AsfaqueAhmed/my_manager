import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/routes.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  bool exitApp = false;

  List<Map<String, String>> items = [
    {
      "image": "order",
      "label": "অর্ডার",
    },
    {
      "image": "design",
      "label": "পেইন্টেড শাড়ি",
    },
    {
      "image": "raw_sari",
      "label": "শাড়ি",
    },
    {
      "image": "cart",
      "label": "সাপ্লায়",
    },
    {
      "image": "factory",
      "label": "কারখানা",
    },
  ];

  void toCustomerList() => _closeDrawerAndNavigateTo(Routes.customerList);

  void newCustomer() => _closeDrawerAndNavigateTo(Routes.addEditCustomer);

  void toSupplierList() => _closeDrawerAndNavigateTo(Routes.supplierList);

  void addSupplier() => _closeDrawerAndNavigateTo(Routes.addEditSupplier);

  openDrawer(BuildContext context) => Scaffold.of(context).openDrawer();

  _closeDrawerAndNavigateTo(String routeName) {
    Get.back();
    Get.toNamed(routeName);
  }

  void toDesignList() => _closeDrawerAndNavigateTo(Routes.designList);

  void addDesign() => _closeDrawerAndNavigateTo(Routes.addEditDesign);

  void requestToExit() {
    if (currentIndex.value != 0) {
      currentIndex(0);
    } else if (exitApp == true) {
      exit(0);
    } else {
      exitApp = true;
      Get.snackbar("সাবধান!!!",
          "আপনি কি অ্যাপ থেকে বের হতে চান?\nতাহলে Exit চাপুন বা পুনরায় ব্যাক প্রেস করুন।",
          mainButton: TextButton(
            onPressed: () => exit(0),
            child: const Text("Exit"),
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          colorText: Colors.white,
          backgroundColor: Colors.red.withOpacity(0.7),
          isDismissible: false, snackbarStatus: (status) {
        if (status == SnackbarStatus.CLOSED) {
          exitApp = false;
        }
      });
    }
  }
}
