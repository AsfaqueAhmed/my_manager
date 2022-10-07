import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/home/controller/home_controller.dart';
import 'package:my_manager/widgets/app_container.dart';

class BottomBar extends GetWidget<HomeController> {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(
                left: controller.selectedPage.value == 0 ? 200 : 300),
            //left: controller.selectedPage.value == 0 ? MediaQuery.of(context).size.width/2 : MediaQuery.of(context).size.width/2-40,
            child: GestureDetector(
              onTap: controller.selectedPage.value != 0 ? controller.add : null,
              child: AppContainer(
                height: 68,
                width: 68,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                radius: BorderRadius.circular(20),
                border: Border.all(),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(
                right: controller.selectedPage.value == 0 ? 0 : 80),
            //left: controller.selectedPage.value == 0 ? MediaQuery.of(context).size.width/2 : MediaQuery.of(context).size.width/2-40,
            child: AppContainer(
              height: 68,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              radius: BorderRadius.circular(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _bottomBarButton(
                      "home", 0, controller.selectedPage.value == 0),
                  const SizedBox(width: 20),
                  _bottomBarButton(
                      "box", 1, controller.selectedPage.value == 1),
                  const SizedBox(width: 20),
                  _bottomBarButton(
                      "brush_paint", 2, controller.selectedPage.value == 2),
                  const SizedBox(width: 20),
                  _bottomBarButton(
                      "shopping-bag", 3, controller.selectedPage.value == 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _bottomBarButton(String icon, int index, bool selected) {
    return GestureDetector(
      onTap: () {
        controller.goToPage(index);
      },
      child: Builder(builder: (context) {
        if (selected) {
          return Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              "assets/bottom_bar_icons/$icon.png",
              color: Colors.white,
              colorBlendMode: BlendMode.multiply,
            ),
          );
        }
        return Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Image.asset("assets/bottom_bar_icons/${icon}1.png"),
        );
      }),
    );
  }
}
