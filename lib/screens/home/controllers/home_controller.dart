import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:my_manager/routes.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

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
}
