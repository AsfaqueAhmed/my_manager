import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/models/raw_sari.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:my_manager/services/designed_sari_service.dart';
import 'package:my_manager/services/file_upload_service.dart';
import 'package:my_manager/services/raw_sari_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditDesignedSariController extends GetxController {
  late TextEditingController titleController,
      detailsController,
      quantityController,
      priceController;

  var images = Rx<List<XFile>>([]);
  var imageUrls = Rx<List<String>>([]);

  DesignedSari? designedSari = Get.arguments;
  RxBool canEdit = true.obs;


  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: designedSari?.title);
    priceController = TextEditingController(text: designedSari?.costing);
    detailsController = TextEditingController(text: designedSari?.details);
    quantityController =
        TextEditingController(text: designedSari?.quantity.toString()??'0');
    canEdit.value = (designedSari == null);
    if (designedSari?.images != null) imageUrls([...(designedSari!.images ?? [])]);
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  save() async {
    if (titleController.text.isEmpty ||
        priceController.text.isEmpty ||
        int.tryParse(quantityController.text) == null) return;
    try {
      DesignedSari designedSari = DesignedSari(
        title: titleController.text,
        details: detailsController.text,
        costing: priceController.text,
        quantity: int.parse(quantityController.text),
      );
      if (this.designedSari != null) {
        designedSari.id = this.designedSari!.id;
      }

      FileUploadService().uploadFiles(
        files: images.value,
        path: designedSari.id,
        onUploadComplete: (List<String> images) async {
          designedSari.images = [...imageUrls.value, ...images];
          Loading.show();
          await DesignedSariService().addNewSari(designedSari);
          Loading.hide();
          Get.back();
          Toaster.success("শাড়ি সংযোজন সফল");
        },
        onUploadFailed: () {
          Loading.hide();
          Toaster.error("শাড়ি সংযোজন সফল হয় নি");
        },
      );
    } catch (error) {
      Loading.hide();
      Toaster.error(error.toString());
    }
  }

  onImageAdded(XFile file) => images.update((val) => val!.add(file));

  onFileRemoved({XFile? file, String? imageLink}) {
    if (file != null) {
      images.update((val) => val!.remove(file));
    }
    if (imageLink != null) {
      imageUrls.update((val) => val!.remove(imageLink));
    }
  }
}
