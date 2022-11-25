import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/widget/multi_image.dart';

class DesignedSariTile extends StatelessWidget {
  final bool showCount;

  const DesignedSariTile({
    Key? key,
    required this.sari,
    this.onTap,
    this.showCount = true,
  }) : super(key: key);

  final DesignedSari sari;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide()),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sari.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (sari.design?.title != null)
                    Text(
                      sari.design?.title ?? "",
                      style: const TextStyle(fontSize: 12, height: 0.9),
                    ),
                  if (sari.rawSari?.title != null)
                    Text(
                      sari.rawSari?.title ?? "",
                      style: const TextStyle(fontSize: 12, height: 1.5),
                    ),
                  if (sari.rawSari?.material != null)
                    Text(
                      sari.rawSari?.material ?? "",
                      style: const TextStyle(fontSize: 12, height: 1),
                    ),
                ],
              ),
            ),
            if (sari.images != null && sari.images!.isNotEmpty)
              const SizedBox(width: 8),
            MultiImage(
              images: sari.images,
              size: 60,
            ),
            if (showCount) const SizedBox(width: 8),
            if (showCount)
              CircleAvatar(
                radius: 22,
                backgroundColor: Get.theme.primaryColor,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          sari.quantity.toString(),
                          style: TextStyle(color: Get.theme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
