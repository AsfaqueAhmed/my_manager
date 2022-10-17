import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_manager/screens/home/controller/home_controller.dart';
import 'package:my_manager/utility/colors.dart';

class NotFound404 extends GetView<HomeController> {
  const NotFound404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/gif/404.gif",
            color: LightThemeColor.primaryColor,
            colorBlendMode: BlendMode.color,
          ),
          Text(
            "Unknown route",
            style: GoogleFonts.montaga(
              color: LightThemeColor.primaryColor,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
