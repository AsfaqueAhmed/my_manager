import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ZoomedImage extends StatelessWidget {
  final String? url;
  final XFile? file;

  static show({String? url, XFile? file}) {
    Get.dialog(ZoomedImage(url: url));
  }

  const ZoomedImage({Key? key, this.url, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: url != null
                ? CachedNetworkImage(
                    imageUrl: url!,
                    fit: BoxFit.contain,
                  )
                : file != null
                    ? Image.file(
                        File(file!.path),
                        fit: BoxFit.contain,
                      )
                    : const SizedBox(),
          ),
        ),
      ),
    );
  }
}
