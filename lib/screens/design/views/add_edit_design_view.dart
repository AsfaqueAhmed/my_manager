import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/screens/supplier/controllers/supplier_controller.dart';
import 'package:my_manager/widget/custom_button.dart';
import 'package:my_manager/widget/image_input_area.dart';
import 'package:my_manager/widget/text_input_widget.dart';

import '../controllers/add_edit_design_controller.dart';

class AddEditDesignView extends StatelessWidget {
  final AddEditDesignController controller = Get.put(AddEditDesignController());
  final supplierController = Get.find<SupplierController>();

  AddEditDesignView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool canEdit = controller.canEdit.value;
        return Scaffold(
          appBar: AppBar(
            title: Builder(builder: (c) {
              if (controller.design == null) {
                return const Text("নতুন ডিজাইন");
              }
              if (canEdit) {
                return const Text("ডিজাইন এডিট");
              }
              return Text(controller.design!.title);
            }),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
            actions: [
              if (controller.design != null)
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
              TextInputWidget(
                hint: "ডিজাইন টাইপ",
                controller: controller.designTypeController,
                enable: canEdit,
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "খরচ",
                controller: controller.costController,
                enable: canEdit,
              ),
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
                  buttonText: "ডিজাইন যোগ করুন",
                  textColor: Colors.white,
                )
            ],
          ),
        );
      },
    );
  }
}
