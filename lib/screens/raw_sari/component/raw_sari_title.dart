import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/raw_sari.dart';
import 'package:my_manager/widget/multi_image.dart';

class RawSariTile extends StatelessWidget {
  final bool removeBorder;

  final bool removeCount;

  const RawSariTile({
    Key? key,
    required this.sari,
    this.onTap,
    this.removeBorder = false,
    this.removeCount = false,
  }) : super(key: key);

  final RawSari sari;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: removeBorder ? null : const Border(bottom: BorderSide()),
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
                  if (sari.material != null)
                    Text(
                      sari.material ?? "",
                      style: const TextStyle(fontSize: 12, height: 0.9),
                    ),
                  if (sari.supplier != null)
                    Text(
                      sari.supplier?.name ?? "",
                      style: const TextStyle(fontSize: 12, height: 1.5),
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
            if (!removeCount) const SizedBox(width: 8),
            if (!removeCount)
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
