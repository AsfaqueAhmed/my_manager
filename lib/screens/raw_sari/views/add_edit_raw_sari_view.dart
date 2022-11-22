import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:my_manager/screens/raw_sari/controllers/add_edit_raw_sari_controller.dart';
import 'package:my_manager/screens/supplier/controllers/supplier_controller.dart';
import 'package:my_manager/widget/checker_item_list.dart';
import 'package:my_manager/widget/custom_buttom.dart';
import 'package:my_manager/widget/dropdown_input_area.dart';
import 'package:my_manager/widget/image_input_area.dart';
import 'package:my_manager/widget/text_input_widget.dart';

class AddEditRawSariView extends StatelessWidget {
  final AddEditRawSariController controller =
      Get.put(AddEditRawSariController());
  final supplierController = Get.find<SupplierController>();

  AddEditRawSariView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool canEdit = controller.canEdit.value;
        return Scaffold(
          appBar: AppBar(
            title: Builder(builder: (c) {
              if (controller.rawSari == null) {
                return const Text("নতুন এক কালার শাড়ি");
              }
              if (canEdit) {
                return const Text("এক কালার শাড়ি এডিট");
              }
              return Text(controller.rawSari!.title);
            }),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
            actions: [
              if (controller.rawSari != null)
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
                        onPressed: () => controller.canEdit(false),
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
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "রং",
                controller: controller.colorController,
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "ম্যাটেরিয়াল",
                controller: controller.materialController,
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "দাম",
                controller: controller.buyingPriceController,
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "পরিমাণ",
                controller: controller.quantityController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () {
                  return DropDownInputArea<Supplier>(
                    title: "সাপ্লায়ার",
                    selectedItem: controller.supplier.value,
                    items: supplierController.supplierList.value ?? [],
                    onSelect: controller.supplier,
                    getId: (item) => item.id,
                    getTitle: (item) => item.name,
                    getSubString: (item) => "${item.mobileNumber}",
                  );
                },
              ),
              const SizedBox(height: 20),
              Obx(
                () {
                  return SingleCheckerItemList<String>(
                    title: "টার্সেল",
                    items: controller.tarcelStatuses,
                    onItemCheck: controller.tarcelStatus,
                    selectedItem: controller.tarcelStatus.value,
                  );
                },
              ),
              const SizedBox(height: 20),
              Obx(
                () => ImageInputArea(
                  title: "ছবি",
                  initialFiles: controller.images.value,
                  onImageAdded: controller.onImageAdded,
                  onFileRemove: controller.onFileRemoved,
                ),
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "বিবরণ",
                controller: controller.detailsController,
              ),
              const SizedBox(height: 32),
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
