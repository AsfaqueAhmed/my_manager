import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/home/controller/home_controller.dart';
import 'package:my_manager/screens/home/ui/pages/dashboard.dart';
import 'package:my_manager/screens/home/ui/pages/design_list.dart';
import 'package:my_manager/screens/home/ui/pages/order_list.dart';
import 'package:my_manager/screens/home/ui/pages/product_list.dart';
import 'package:my_manager/widgets/bottom_bar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: const [
              Dashboard(),
              ProductList(),
              DesignList(),
              OrderList(),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: BottomBar(),
            ),
          ),
        ],
      ),
    );
  }
}
