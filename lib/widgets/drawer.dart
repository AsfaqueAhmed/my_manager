import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_manager/utility/colors.dart';
import 'package:my_manager/widgets/app_container.dart';

class ApplicationDrawer extends StatelessWidget {
  final expandedTitle = "".obs;

  ApplicationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: LightThemeColor.primaryColor,
      child: ListView(
        children: [
          _expandableDrawerButton("type", "Type"),
          _expandableDrawerButton("brush_paint", "Material"),
          _expandableDrawerButton("box", "Product"),
          _expandableDrawerButton("shopping-bag", "Orders"),
        ],
      ),
    );
  }

  _expandableDrawerButton(String icon, String title) {
    return Obx(() {
      bool selected = expandedTitle.value == title;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16) +
            const EdgeInsets.only(top: 12),
        child: GestureDetector(
          onTap: () {
            expandedTitle.value = title;
          },
          child: AppContainer(
            padding: const EdgeInsets.all(12),
            radius: BorderRadius.circular(8),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/bottom_bar_icons/$icon${selected ? "" : '1'}.png",
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    AnimatedRotation(turns: selected?0.5:0,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(Icons.arrow_drop_down_sharp),

                    )
                  ],
                ),
                ClipRect(
                  child: Align(
                    heightFactor: selected ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _drawerSubItem("Add $title", Icons.add, selected),
                        _drawerSubItem("$title List", Icons.list, selected),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _drawerSubItem(String title, IconData icon, bool selected) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(left: 32),
      padding: const EdgeInsets.all(8),
      height: 44,
      child: Row(
        children: [
          Icon(
            icon,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
