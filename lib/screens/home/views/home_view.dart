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
    return WillPopScope(
      onWillPop: () async {
        controller.requestToExit();
        return false;
      },
      child: Scaffold(
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
      ),
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
          const SizedBox(height: 24),
          _expansionDrawerTile(
            title: "কাস্টমার",
            listIcon: Icons.person_outline,
            addIcon: Icons.person_add_alt,
            onShowList: controller.toCustomerList,
            onAddItem: controller.newCustomer,
          ),
          _expansionDrawerTile(
            title: "সাপ্লায়ার",
            listIcon: Icons.account_tree_outlined,
            addIcon: Icons.add,
            onShowList: controller.toSupplierList,
            onAddItem: controller.addSupplier,
          ),
          _expansionDrawerTile(
            title: "ডিজাইন",
            listIcon: Icons.image_aspect_ratio_outlined,
            addIcon: Icons.draw_outlined,
            onShowList: controller.toDesignList,
            onAddItem: controller.addDesign,
          ),
        ],
      ),
    );
  }

  ExpansionTile _expansionDrawerTile({
    required String title,
    required IconData listIcon,
    required IconData addIcon,
    required Function() onShowList,
    required Function() onAddItem,
  }) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16),
      collapsedIconColor: Colors.white,
      iconColor: Colors.white,
      backgroundColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.2),
      title: _text(title),
      children: [
        ListTile(
          leading: _icon(listIcon),
          title: _text("$title তালিকা"),
          onTap: onShowList,
        ),
        ListTile(
          leading: _icon(addIcon),
          title: _text("নতুন $title"),
          onTap: onAddItem,
        ),
      ],
    );
  }

  Icon _icon(IconData listIcon) => Icon(
        listIcon,
        color: Colors.white,
      );

  Text _text(String title) => Text(
        title,
        style: const TextStyle(color: Colors.white),
      );
}
