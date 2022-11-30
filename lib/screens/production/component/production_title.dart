import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/models/production.dart';
import 'package:my_manager/screens/production/controllers/production_controller.dart';
import 'package:my_manager/widget/multi_image.dart';

class ProductionTile extends StatelessWidget {
  final bool showCount;

  const ProductionTile({
    Key? key,
    required this.item,
    this.onTap,
    this.showCount = true,
  }) : super(key: key);

  final ProductionItem item;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    DesignedSari item = this.item.designedSari;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide()),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.find<ProductionController>()
                        .showProductionStatusChangeDialog(this.item);
                  },
                  child: this.item.status.getUi(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.design?.title != null)
                        Text(
                          item.design?.title ?? "",
                          style: const TextStyle(fontSize: 12, height: 0.9),
                        ),
                      if (item.rawSari?.title != null)
                        Text(
                          item.rawSari?.title ?? "",
                          style: const TextStyle(fontSize: 12, height: 1.5),
                        ),
                      if (item.rawSari?.material != null)
                        Text(
                          item.rawSari?.material ?? "",
                          style: const TextStyle(fontSize: 12, height: 1),
                        ),
                    ],
                  ),
                ),
                MultiImage(
                  images: item.images ?? [],
                  size: 48,
                  imageCount: 1,
                ),
                MultiImage(
                  images: item.design?.images ?? [],
                  size: 48,
                  imageCount: 1,
                ),
                MultiImage(
                  images: item.rawSari?.images ?? [],
                  size: 48,
                  imageCount: 1,
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
                              this.item.quantity.toString(),
                              style: TextStyle(color: Get.theme.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
