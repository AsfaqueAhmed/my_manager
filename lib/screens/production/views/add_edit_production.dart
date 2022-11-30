import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/screens/designed_sari/component/designed_raw_sari_title.dart';
import 'package:my_manager/widget/custom_button.dart';
import 'package:my_manager/widget/custom_dropdown_input_area.dart';
import 'package:my_manager/widget/multi_image.dart';
import 'package:my_manager/widget/text_input_widget.dart';

import '../controllers/add_edit_production_controller.dart';

class AddEditProductionItem extends StatelessWidget {
  final AddEditProductionController controller =
      Get.put(AddEditProductionController());

  AddEditProductionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool canEdit = controller.canEdit.value;
        return Scaffold(
          appBar: AppBar(
            title: Builder(builder: (c) {
              if (controller.productionItem == null) {
                return const Text("নতুন প্রডাক্ট");
              }
              if (canEdit) {
                return const Text("প্রডাক্ট এডিট");
              }
              return Text(controller.productionItem!.designedSari.title);
            }),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
            actions: [
              if (controller.productionItem != null)
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
              Obx(
                () => CustomDropDownInputArea<DesignedSari>(
                  title: "ডিজাইন",
                  enable: canEdit,
                  selectedItem: controller.designedSari.value,
                  onSelect: controller.designedSari,
                  getId: (design) => design.id,
                  items: controller.designedSariList,
                  pickerItemBuilder: (sari) => DesignedSariTile(
                    sari: sari,
                    showCount: false,
                  ),
                  pickedItemBuilder: (sari) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sari.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (sari.design?.title != null)
                                  Text(
                                    sari.design?.title ?? "",
                                    style: const TextStyle(
                                        fontSize: 12, height: 0.9),
                                  ),
                                if (sari.rawSari?.title != null)
                                  Text(
                                    sari.rawSari?.title ?? "",
                                    style: const TextStyle(
                                        fontSize: 12, height: 1.5),
                                  ),
                                if (sari.rawSari?.material != null)
                                  Text(
                                    sari.rawSari?.material ?? "",
                                    style: const TextStyle(
                                        fontSize: 12, height: 1),
                                  ),
                              ],
                            ),
                          ),
                          MultiImage(
                            images: sari.design?.images ?? [],
                            size: 48,
                            imageCount: 1,
                          ),
                          MultiImage(
                            images: sari.rawSari?.images ?? [],
                            size: 48,
                            imageCount: 1,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
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
              if (canEdit) const SizedBox(height: 32),
              if (canEdit)
                CustomButton(
                  onPressed: controller.save,
                  buttonText: "প্রোডাক্ট যোগ করুন",
                  textColor: Colors.white,
                )
            ],
          ),
        );
      },
    );
  }
}
