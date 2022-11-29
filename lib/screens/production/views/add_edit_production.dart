import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/design.dart';
import 'package:my_manager/models/raw_sari.dart';
import 'package:my_manager/screens/design/component/design_title.dart';
import 'package:my_manager/screens/raw_sari/component/raw_sari_title.dart';
import 'package:my_manager/screens/supplier/controllers/supplier_controller.dart';
import 'package:my_manager/widget/custom_button.dart';
import 'package:my_manager/widget/custom_dropdown_input_area.dart';
import 'package:my_manager/widget/image_input_area.dart';
import 'package:my_manager/widget/text_input_widget.dart';

import '../controllers/add_edit_production_controller.dart';

class AddEditDesignedSariView extends StatelessWidget {
  final AddEditDesignedSariController controller =
      Get.put(AddEditDesignedSariController());
  final supplierController = Get.find<SupplierController>();

  AddEditDesignedSariView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool canEdit = controller.canEdit.value;
        return Scaffold(
          appBar: AppBar(
            title: Builder(builder: (c) {
              if (controller.designedSari == null) {
                return const Text("নতুন ডিজাইনড শাড়ি");
              }
              if (canEdit) {
                return const Text("ডিজাইনড শাড়ি এডিট");
              }
              return Text(controller.designedSari!.title);
            }),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
            actions: [
              if (controller.designedSari != null)
                Builder(builder: (c) {
                  if (!canEdit) {
                    return IconButton(
                        onPressed: () => controller.canEdit(true),
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ));
                  } else {
                    return IconButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          controller.canEdit(false);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ));
                  }
                })
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              TextInputWidget(
                hint: "টাইটেল",
                controller: controller.titleController,
                enable: canEdit,
              ),
              const SizedBox(height: 20),
              Obx(
                () => CustomDropDownInputArea<RawSari>(
                  title: "শাড়ি",
                  enable: canEdit,
                  selectedItem: controller.rawSari.value,
                  onSelect: controller.rawSari,
                  getId: (sari) => sari.id,
                  items: controller.rawSariList,
                  pickerItemBuilder: (design) => RawSariTile(sari: design,removeCount:true),
                  pickedItemBuilder: (design) => RawSariTile(sari: design,removeBorder: true,removeCount:true),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => CustomDropDownInputArea<Design>(
                  title: "ডিজাইন",
                  enable: canEdit,
                  selectedItem: controller.design.value,
                  onSelect: controller.design,
                  getId: (design) => design.id,
                  items: controller.designList,
                  pickerItemBuilder: (design) => DesignTile(design: design),
                  pickedItemBuilder: (design) => DesignTile(design: design,removeBorder: true,),
                ),
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "দাম",
                controller: controller.priceController,
                enable: canEdit,
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "পরিমাণ",
                controller: controller.quantityController,
                enable: canEdit,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                ),
              ),
              const SizedBox(height: 12),
              if (controller.designedSari?.images != null &&
                  controller.designedSari!.images!.isNotEmpty &&
                  controller.images.value.isNotEmpty)
                const SizedBox(height: 20),
              Obx(
                () => ImageInputArea(
                  title: "ছবি",
                  initialFiles: controller.images.value,
                  initialImageLink: controller.imageUrls.value,
                  onImageAdded: controller.onImageAdded,
                  onFileRemove: controller.onFileRemoved,
                  enable: canEdit,
                ),
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "বিবরণ",
                controller: controller.detailsController,
                enable: canEdit,
                lines: 3,
              ),
              if (canEdit) const SizedBox(height: 32),
              if (canEdit)
                CustomButton(
                  onPressed: controller.save,
                  buttonText: "শাড়ি যোগ করুন",
                  textColor: Colors.white,
                )
            ],
          ),
        );
      },
    );
  }
}
