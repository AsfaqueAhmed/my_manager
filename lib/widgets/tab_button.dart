import 'package:flutter/material.dart';
import 'package:my_manager/utility/colors.dart';
import 'package:my_manager/widgets/app_container.dart';

class TabButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool selected;

  const TabButton(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppContainer(
        height: 54,
        width: double.infinity,
        color: selected ? Colors.white : LightThemeColor.primaryColor,
        radius: BorderRadius.circular(8),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              selected
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AppContainer(
                        height: 16,
                        width: 16,
                        radius: BorderRadius.circular(8),
                        child: const Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 10,
                        ),
                      ),
                    )
                  : const SizedBox(),
              Text(
                title,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
