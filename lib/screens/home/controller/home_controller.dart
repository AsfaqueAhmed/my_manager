import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:my_manager/routes.dart';

class HomeController extends GetConnect {
  var selectedPage = 0.obs;

  PageController pageController = PageController();

  @override
  void onClose() {
    super.onInit();
    pageController.dispose();
  }

  void goToPage(int index) {
    if (index != selectedPage.value) {
      selectedPage.value = index;
      pageController.jumpToPage(index);
    }
  }

  void addNewItem() {
    if (selectedPage.value == 2) Get.toNamed(Routes.addDesign);
    if (selectedPage.value == 1) Get.toNamed(Routes.addProduct);
  }
}
