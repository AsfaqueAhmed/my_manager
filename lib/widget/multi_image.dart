import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultiImage extends StatelessWidget {
  final List<String>? images;
  final double size;
  final int imageCount;

  const MultiImage({
    Key? key,
    required this.images,
    this.size = 60,
    this.imageCount = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) return SizedBox(height: size);
    var factor = .33;
    return SizedBox(
      width:
          (size * (1 + factor * (images!.length.clamp(0, imageCount) - 1))),
      height: size,
      child: Stack(
        children: List.generate(images!.length.clamp(0, imageCount), (index) {
          return Positioned(
            right: index * factor * size,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2, color: Get.theme.scaffoldBackgroundColor),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(images![index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
