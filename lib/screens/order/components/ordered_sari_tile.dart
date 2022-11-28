import 'package:flutter/material.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/models/ordered_sari.dart';
import 'package:my_manager/widget/input_box.dart';
import 'package:my_manager/widget/multi_image.dart';

class OrderedSariTile extends StatelessWidget {
  const OrderedSariTile({
    Key? key,
    required this.orderedSari,
    this.onRemove,
    this.onEdit,
  }) : super(key: key);

  final OrderedSari orderedSari;
  final Function()? onRemove;
  final Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    DesignedSari sari = orderedSari.designedSari;
    return InputBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2) +
                const EdgeInsets.only(right: 4),
            child: Row(
              children: [
                MultiImage(
                  images: sari.images,
                  size: 60,
                  imageCount: 2,
                ),
                if (sari.images != null && sari.images!.isNotEmpty)
                  const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sari.title,
                        style: const TextStyle(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "পরিমাণঃ ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "মূল্যঃ ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "মোটঃ ",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "x ${orderedSari.quantity}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "৳ ${orderedSari.unitPrice}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      "৳ ${orderedSari.quantity * orderedSari.unitPrice}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (onRemove != null || onEdit != null)
            Positioned(
              right: 12,
              top: -16,
              child: Row(
                children: [
                  if (onEdit != null)
                    _buildActionButton(
                      icon: Icons.edit,
                      onPress: onEdit!,
                      color: Colors.black,
                    ),
                  if (onRemove != null) const SizedBox(width: 12),
                  if (onRemove != null)
                    _buildActionButton(
                      icon: Icons.delete_forever_outlined,
                      onPress: onRemove!,
                      color: Colors.red,
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }

  GestureDetector _buildActionButton({
    required IconData icon,
    required Function() onPress,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onPress,
      child: InputBox(
          height: 28,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 4, left: 4),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          )),
    );
  }
}
