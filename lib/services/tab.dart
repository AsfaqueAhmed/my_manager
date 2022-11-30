import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/config/colors.dart';

class MyTabBar<T> extends StatelessWidget {
  final Rx<T> selectedTab;
  final List<T> tabs;
  final String Function(T)? getTitle;
  final Function(T) onSwitchTab;

  const MyTabBar({
    Key? key,
    required this.selectedTab,
    required this.tabs,
    required this.onSwitchTab,
    this.getTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _tabs();
  }

  Obx _tabs() {
    return Obx(
      () => Row(
        children: tabs.map((status) => _tab(status)).toList(),
      ),
    );
  }

  Expanded _tab(T tab) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onSwitchTab(tab),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selectedTab.value == tab
                    ? Get.theme.primaryColor
                    : AppColors.disable,
                width: selectedTab.value == tab ? 2 : 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          height: 48,
          child: Center(
              child: FittedBox(
            child: Text(
              getTitle == null ? tab.toString() : getTitle!(tab),
              style: TextStyle(
                color: selectedTab.value == tab
                    ? Get.theme.primaryColor
                    : AppColors.disable,
                fontWeight: selectedTab.value == tab
                    ? FontWeight.bold
                    : FontWeight.w200,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
