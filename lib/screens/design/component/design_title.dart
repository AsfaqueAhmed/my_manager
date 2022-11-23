import 'package:flutter/material.dart';
import 'package:my_manager/models/design.dart';
import 'package:my_manager/widget/multi_image.dart';

class DesignTile extends StatelessWidget {
  const DesignTile({
    Key? key,
    required this.design,
    this.onTap,
  }) : super(key: key);

  final Design design;
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
                    design.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    design.designType,
                    style: const TextStyle(fontSize: 12, height: 0.9),
                  ),
                ],
              ),
            ),
            if (design.images != null && design.images!.isNotEmpty)
              const SizedBox(width: 8),
            MultiImage(
              images: design.images,
              size: 60,
            ),
          ],
        ),
      ),
    );
  }
}
