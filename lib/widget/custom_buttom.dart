import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? textColor;
  final double? borderRadius;
  final String buttonText;
  final bool fullScreenButton;
  final Function() onPressed;
  final EdgeInsets? padding;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomButton({
    Key? key,
    this.buttonColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.fullScreenButton = false,
    this.buttonText = "Save",
    this.fontSize,
    this.fontWeight,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullScreenButton ? double.infinity : null,
      child: RawMaterialButton(
        elevation: 1,
        focusElevation: 2,
        highlightElevation: 2,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4)),
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
        fillColor: buttonColor ?? Get.theme.primaryColor,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
