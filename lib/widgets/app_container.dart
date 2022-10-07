import 'package:flutter/material.dart';
import 'package:my_manager/utility/colors.dart';

class AppContainer extends StatelessWidget {
  final EdgeInsets padding;
  final BorderRadius radius;
  final Color color;
  final Border? border;
  final Widget child;
  final double? height;
  final double? width;

  const AppContainer({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.radius = BorderRadius.zero,
    this.color = LightThemeColor.primaryColor,
    this.border,
    this.width,
    this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: radius,
        border: border ?? Border.all(),
      ),
      child: child,
    );
  }
}
