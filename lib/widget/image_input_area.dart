import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputArea extends StatefulWidget {
  final String title;
  final List<XFile>? initialFiles;
  final List<String>? initialImageLink;
  final Function(XFile file) onImageAdded;
  final Function({XFile? file, String? imageLink}) onFileRemove;
  final double size;

  const ImageInputArea({
    Key? key,
    this.size = 90,
    required this.title,
    this.initialFiles,
    this.initialImageLink,
    required this.onImageAdded,
    required this.onFileRemove,
  }) : super(key: key);

  @override
  State<ImageInputArea> createState() => _ImageInputAreaState();
}

class _ImageInputAreaState extends State<ImageInputArea> {
  late List<String> fileUrls;
  late List<XFile> files;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    files = widget.initialFiles ?? [];
    fileUrls = widget.initialImageLink ?? [];
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "ছবি (${(widget.initialFiles?.length ?? 0) + (widget.initialImageLink?.length ?? 0)})",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: widget.size,
          child: ListView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            children: [
              ...fileUrls.map((link) => _ImageBox(
                    size: widget.size - 8,
                    fileUrl: link,
                    onRemove: () => widget.onFileRemove(imageLink: link),
                  )),
              ...files.map((file) => _ImageBox(
                    size: widget.size - 8,
                    file: file,
                    onRemove: () => widget.onFileRemove(file: file),
                  )),
              _ImageBox(size: widget.size - 8, onFileAdded: onImageAdded)
            ],
          ),
        ),
      ],
    );
  }

  onImageAdded(XFile image) {
    widget.onImageAdded(image);
    Future.delayed(const Duration(milliseconds: 500), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
}

class _ImageBox extends StatelessWidget {
  final XFile? file;
  final String? fileUrl;
  final Function()? onRemove;
  final Function(XFile)? onFileAdded;
  final double size;

  const _ImageBox({
    Key? key,
    this.file,
    this.fileUrl,
    this.onRemove,
    this.onFileAdded,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.5, color: Colors.grey),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Builder(
              builder: (context) {
                if (fileUrl != null) {
                  return CachedNetworkImage(
                    height: size,
                    width: size,
                    imageUrl: fileUrl!,
                    fit: BoxFit.cover,
                  );
                } else if (file != null) {
                  return Image.file(
                    height: size,
                    width: size,
                    File(file!.path),
                    fit: BoxFit.cover,
                  );
                } else if (onFileAdded == null) {
                  return const SizedBox();
                } else {
                  return GestureDetector(
                    onTap: _pickFile,
                    child: const Center(
                      child: Icon(Icons.add_photo_alternate_outlined,
                          color: Colors.grey, size: 36),
                    ),
                  );
                }
              },
            ),
            if ((file != null || fileUrl != null) && onRemove != null)
              Positioned(
                top: 1,
                right: 1,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(4)),
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _pickFile() {
    ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
      maxHeight: 600,
      maxWidth: 600,
    )
        .then((value) {
      if (value != null) {
        onFileAdded!(value);
      }
    });
  }
}
