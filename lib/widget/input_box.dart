import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final Widget child;
  final bool usePadding;

  final bool showBorder;

  final bool fixedHeight;

  final Color? bg;

  final Color? borderColor;

  final bool? hasError;
  final bool? hideError;
  final double? height;

  const InputBox(
      {Key? key,
      required this.child,
      this.usePadding = true,
      this.showBorder = true,
      this.fixedHeight = true,
      this.bg,
      this.borderColor,
      this.hasError = false,
      this.hideError,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? (fixedHeight ? 46 : null),
      padding: fixedHeight
          ? EdgeInsets.only(top: usePadding ? 4 : 0)
          : const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: showBorder
            ? Border.all(
                width: hasError == true ? 0.5 : 0.3,
                color: hasError == true
                    ? const Color(0xffA31911)
                    : const Color(0xff858585),
              )
            : null,
        color: Colors.white, //bg ?? tintColor(primaryDarkColor, 0.92),
      ),
      child: child,
    );
  }
}
