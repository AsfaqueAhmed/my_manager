import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/home/controller/home_controller.dart';
import 'package:my_manager/widgets/app_top_bar.dart';

class OrderList extends GetView<HomeController> {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          AppTopBar(title: "Oder List"),
        ],
      ),
    );
  }
}
