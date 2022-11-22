import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_manager/models/raw_sari.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:my_manager/services/file_upload_service.dart';
import 'package:my_manager/services/raw_sari_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditRawSariController extends GetxController {
  late TextEditingController titleController,
      colorController,
      materialController,
      detailsController,
      quantityController,
      buyingPriceController;

  var images = Rx<List<XFile>>([]);

  Rx<Supplier?> supplier = Rx<Supplier?>(null);
  RawSari? rawSari = Get.arguments;
  RxBool canEdit = true.obs;

  late RxString tarcelStatus;

  var tarcelStatuses = const ["টার্সেল আছে", "টার্সেল নাই"];

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: rawSari?.title);
    colorController = TextEditingController(text: rawSari?.color);
    buyingPriceController = TextEditingController(text: rawSari?.buyingPrice);
    materialController = TextEditingController(text: rawSari?.material);
    detailsController = TextEditingController(text: rawSari?.details);
    quantityController =
        TextEditingController(text: rawSari?.quantity.toString());
    tarcelStatus = RxString(tarcelStatuses[0]);
    supplier.value = rawSari?.supplier;
    canEdit.value = (rawSari == null);
  }

  @override
  void dispose() {
    titleController.dispose();
    colorController.dispose();
    buyingPriceController.dispose();
    materialController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  save() async {
    if (titleController.text.isEmpty ||
        colorController.text.isEmpty ||
        buyingPriceController.text.isEmpty ||
        materialController.text.isEmpty ||
        int.tryParse(quantityController.text) == null) return;
    try {
      RawSari rawSari = RawSari(
        title: titleController.text,
        color: colorController.text,
        material: materialController.text,
        buyingPrice: buyingPriceController.text,
        supplier: supplier.value,
        tercell: tarcelStatuses.indexOf(tarcelStatus.value) == 0,
        details: detailsController.text,
        quantity: int.parse(quantityController.text),
      );

      FileUploadService().uploadFiles(
        files: images.value,
        path: rawSari.id,
        onUploadComplete: (List<String> images) async {
          rawSari.images = images;
          Loading.show();
          await RawSariService().addNewSari(rawSari);
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
    print("called");
    if (file != null) {
      images.update((val) => val!.remove(file));
    }
  }
}
