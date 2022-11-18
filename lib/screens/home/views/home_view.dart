import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/designed_sari/views/designed_sari_view.dart';
import 'package:my_manager/screens/order/views/order_view.dart';
import 'package:my_manager/screens/raw_sari/views/raw_sari_view.dart';
import 'package:my_manager/screens/supply/views/supply_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        title: Obx(
          () => Text(
            "${controller.items[controller.currentIndex.value]['label']}",
          ),
        ),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => controller.openDrawer(context),
          );
        }),
      ),
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: controller.currentIndex.value == 0
              ? OrderView()
              : controller.currentIndex.value == 1
                  ? DesignedSariView()
                  : controller.currentIndex.value == 2
                      ? RawSariView()
                      : controller.currentIndex.value == 3
                          ? SupplyView()
                          : Container(),
        ),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Obx _bottomBar() {
    return Obx(
      () => BottomAppBar(
        child: SizedBox(
          height: 68,
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.currentIndex,
            backgroundColor: Get.theme.appBarTheme.backgroundColor,
            // selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[300],
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: controller.items
                .map((e) => BottomNavigationBarItem(
                      backgroundColor: Get.theme.appBarTheme.backgroundColor,
                      icon: bottomBarIcon(e['image']!, false),
                      activeIcon: bottomBarIcon(e['image']!, true),
                      label: e['label'],
                    ))
                .toList(),
            showUnselectedLabels: true,
          ),
        ),
      ),
    );
  }

  Widget bottomBarIcon(String icon, bool state) => Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 2),
        child: Image.asset(
          "assets/bottom_bar_icons/${icon}_${state ? 2 : 1}.png",
          height: state ? 28 : 26,
          color: state ? null : Colors.grey[300],
        ),
      );

  _drawer() {
    return Drawer(
      backgroundColor: Get.theme.appBarTheme.backgroundColor,
      child: ListView(
        children: [
          const SizedBox(height: 60),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("কাস্টমার"),
            onTap: controller.toCustomerList,
          ),
          ListTile(
            leading: const Icon(Icons.person_add_alt),
            title: const Text("নতুন কাস্টমার"),
            onTap: controller.newCustomer,
          ),
          ListTile(
            leading: const Icon(Icons.account_tree_outlined),
            title: const Text("সাপ্লায়ার"),
            onTap: controller.toSupplierList,
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("নতুন সাপ্লায়ার"),
            onTap: controller.addSupplier,
          ),
        ],
      ),
    );
  }
}
