import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadService {
  static FileUploadService? _instance;

  var collection = FirebaseFirestore.instance.collection("customer");

  factory FileUploadService() {
    _instance ??= FileUploadService._();

    return _instance!;
  }

  FileUploadService._();

  uploadFiles({
    required List<XFile> files,
    required String path,
    required Function(List<String>) onUploadComplete,
    required Function() onUploadFailed,
  }) async {
    List<String> urls = [];
    if (files.isNotEmpty) {
      RxString title = "Uploading File".obs;
      RxInt progress = 0.obs;
      Get.bottomSheet(Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  title.value,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            height: 20,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.grey,
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: progress.value.toDouble() / 100,
                            heightFactor: 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.green,
                              ),
                              height: 20,
                              width: double.infinity,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ));
      int i = 1;

      for (var file in files) {
        title.value = "Uploading File - $i of ${files.length}";
        await uploadFile(
          file: file,
          path: path,
          onUploadComplete: (url) => urls.add(url),
          onUploadFailed: onUploadFailed,
          onProgress: progress,
        );
        i++;
      }

      Get.back();
    }
    onUploadComplete(urls);
  }

  uploadFile({
    required XFile file,
    required String path,
    required Function(String) onUploadComplete,
    required Function() onUploadFailed,
    required Function(int progress) onProgress,
  }) async {
    UploadTask? task = _uploadFile(file, path);
    task.snapshotEvents.listen((event) async {
      switch (event.state) {
        case TaskState.paused:
          task.cancel();
          break;
        case TaskState.running:
          onProgress((event.bytesTransferred / event.totalBytes * 100).toInt());
          break;
        case TaskState.success:
          break;
        case TaskState.canceled:
          onUploadFailed();
          break;
        case TaskState.error:
          onUploadFailed();
          break;
      }
    });
    await task.whenComplete(
        () async => onUploadComplete(await task.snapshot.ref.getDownloadURL()));
  }

  UploadTask _uploadFile(XFile file, String path) {
    UploadTask uploadTask;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child(path)
        .child("/${_path(file.path)}");

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    uploadTask = ref.putFile(File(file.path), metadata);

    return uploadTask;
  }

  _path(String path) => path.split('/').last;
}
