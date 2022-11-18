import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickerItem extends StatelessWidget {
  final String title;
  final String? subTitle2;
  final String? subTitle1;
  final bool isSelected;
  final PickerItemType type;

  final double? size;

  const PickerItem({
    Key? key,
    required this.title,
    this.type = PickerItemType.radio,
    this.isSelected = false,
    this.size,
    this.subTitle1,
    this.subTitle2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryDarkColor = Get.theme.primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        //color: isSelected ? tintColor(primaryDarkColor, 0.9) : Colors.white,
        //border: Border.all(color: isSelected ? primaryDarkColor : Colors.white),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          type == PickerItemType.check
              ? Container(
                  margin: EdgeInsets.only(bottom: 2),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: isSelected ? primaryDarkColor : Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: primaryDarkColor, width: 1.5)),
                  padding: EdgeInsets.only(bottom: 8, right: 2),
                  alignment: Alignment.bottomCenter,
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 18,
                          color: Colors.white,
                        )
                      : SizedBox(),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 2),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryDarkColor, width: 1.5)),
                  padding: EdgeInsets.all(3),
                  child: isSelected
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryDarkColor,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size ?? 16.0,
                  ),
                ),
                if (subTitle1 != null || subTitle2 != null)
                  Row(
                    children: [
                      if (subTitle1 != null)
                        Expanded(
                          child: Text(
                            subTitle1!,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      Spacer(),
                      if (subTitle2 != null)
                        Text(
                          subTitle2!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13.0,
                          ),
                        )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PickerItem2 extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool isSelected;
  final PickerItemType type;

  final double? size;

  const PickerItem2({
    Key? key,
    required this.title,
    this.type = PickerItemType.radio,
    this.isSelected = false,
    this.size,
    this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color primaryDarkColor = Get.theme.primaryColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        //color: isSelected ? tintColor(primaryDarkColor, 0.9) : Colors.white,
        //border: Border.all(color: isSelected ? primaryDarkColor : Colors.white),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*isSelected
              ? Icon(
                  Icons.radio_button_on,
                  color: primaryDarkColor,
                  size: (size ?? 16) + 2,
                )
              : Icon(
                  Icons.radio_button_off,
                  size: (size ?? 16) + 2,
                ),*/
          type == PickerItemType.check
              ? Container(
                  margin: EdgeInsets.only(bottom: 2),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isSelected ? primaryDarkColor : Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: primaryDarkColor, width: 1.5),
                  ),
                  padding: EdgeInsets.only(bottom: 8, right: 2),
                  alignment: Alignment.bottomCenter,
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 18,
                          color: Colors.white,
                        )
                      : SizedBox(),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 2),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primaryDarkColor,
                      width: 1.5,
                    ),
                  ),
                  padding: EdgeInsets.all(3),
                  child: isSelected
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryDarkColor,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size ?? 15.0,
                  ),
                ),
                if (subTitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text(
                      subTitle!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum PickerItemType { radio, check }
