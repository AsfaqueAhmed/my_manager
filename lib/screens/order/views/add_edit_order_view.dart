import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/ordered_sari.dart';
import 'package:my_manager/screens/order/components/add_new_product_ui.dart';
import 'package:my_manager/screens/order/components/ordered_sari_tile.dart';
import 'package:my_manager/screens/supplier/controllers/supplier_controller.dart';
import 'package:my_manager/widget/custom_button.dart';
import 'package:my_manager/widget/text_input_widget.dart';

import '../controllers/add_edit_order_controller.dart';

class AddEditOrderView extends StatelessWidget {
  final AddEditOrderController controller = Get.put(AddEditOrderController());
  final supplierController = Get.find<SupplierController>();

  AddEditOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        bool canEdit = controller.canEdit.value;
        return Scaffold(
          appBar: AppBar(
            title: Builder(builder: (c) {
              if (controller.order == null) {
                return const Text("নতুন অর্ডার");
              }
              if (canEdit) {
                return const Text("অর্ডার এডিট");
              }
              return const Text("অর্ডার");
            }),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => Get.back(),
            ),
            actions: [
              if (controller.order != null)
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
                hint: "কাস্টমার নাম",
                controller: controller.customerNameController,
                enable: canEdit,
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "কাস্টমার নাম্বার",
                controller: controller.customerNumberController,
                enable: canEdit,
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "কাস্টমার এড্রেস",
                controller: controller.customerAddressController,
                enable: canEdit,
              ),
              const SizedBox(height: 4),
              Obx(
                () {
                  List<OrderedSari> saris = controller.orderedSari.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "সিলেক্টেড ডিজাইনড শাড়ি",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...saris.map((sari) => Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: OrderedSariTile(
                              orderedSari: sari,
                              onRemove: () =>
                                  controller.onRemoveOrderedSari(sari),
                              onEdit: () =>
                                  controller.onEditOrderedSari(sari),
                            ),
                      )),
                      if (canEdit)
                        AddNewProductUi(
                          onDesignPicked: controller.onNewItemAdd,
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              TextInputWidget(
                hint: "বিবরণ",
                controller: controller.customerNumberController,
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
