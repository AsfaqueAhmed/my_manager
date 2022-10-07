import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_manager/widgets/app_container.dart';

class AppTopBar extends StatelessWidget {
  final String title;
  final bool enableBack;

  const AppTopBar({
    Key? key,
    required this.title,
    this.enableBack = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      height: 56 + MediaQuery.of(context).padding.top,
      width: double.infinity,
      padding:
          EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            enableBack
                ? GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(right: 8),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                  )
                : const SizedBox(),
            Text(title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
      ),
    );
  }
}
