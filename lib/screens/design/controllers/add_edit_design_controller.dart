import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_manager/models/design.dart';
import 'package:my_manager/services/design_service.dart';
import 'package:my_manager/services/file_upload_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditDesignController extends GetxController {
  late TextEditingController titleController,
      designTypeController,
      detailsController,
      costController;

  var images = Rx<List<XFile>>([]);
  var imageUrls = Rx<List<String>>([]);

  Design? design = Get.arguments;
  RxBool canEdit = true.obs;


  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: design?.title);
    designTypeController = TextEditingController(text: design?.designType);
    costController = TextEditingController(text: design?.costing);
    detailsController = TextEditingController(text: design?.details);
    canEdit.value = (design == null);
    if (design?.images != null) imageUrls([...(design!.images ?? [])]);
  }

  @override
  void dispose() {
    titleController.dispose();
    designTypeController.dispose();
    costController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  save() async {
    if (titleController.text.isEmpty ||
        designTypeController.text.isEmpty ||
        costController.text.isEmpty ||
        costController.text.isEmpty) return;
    try {
      Design design = Design(
        title: titleController.text,
        designType: designTypeController.text,
        costing: costController.text,
        details: detailsController.text,
      );
      if (this.design != null) {
        design.id = this.design!.id;
      }

      FileUploadService().uploadFiles(
        files: images.value,
        path: design.id,
        onUploadComplete: (List<String> images) async {
          design.images = [...imageUrls.value, ...images];
          Loading.show();
          await DesignService().addDesign(design);
          Loading.hide();
          Get.back();
          Toaster.success("ডিজাইন সংযোজন সফল");
        },
        onUploadFailed: () {
          Loading.hide();
          Toaster.error("ডিজাইন সংযোজন সফল হয় নি");
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
