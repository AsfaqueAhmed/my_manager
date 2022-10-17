import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/home/controller/home_controller.dart';
import 'package:my_manager/widgets/app_top_bar.dart';

class Dashboard extends GetView<HomeController> {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: const [
        AppTopBar(title: "Dashboard",hasDrawer:true),
      ],
    );
  }
}
