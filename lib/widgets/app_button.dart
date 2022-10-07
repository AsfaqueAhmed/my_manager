import 'package:flutter/material.dart';
import 'package:my_manager/utility/colors.dart';
import 'package:my_manager/widgets/app_container.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? color;

  const AppButton(
      {Key? key, required this.title, required this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppContainer(
        height: 54,
        width: double.infinity,
        color: color ?? LightThemeColor.primaryColor,
        radius: BorderRadius.circular(8),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
