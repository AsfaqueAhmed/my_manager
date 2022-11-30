import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/models/production.dart';
import 'package:my_manager/screens/designed_sari/controllers/designed_sari_controller.dart';
import 'package:my_manager/services/production_service.dart';
import 'package:my_manager/services/raw_sari_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditProductionController extends GetxController {
  late TextEditingController quantityController;

  ProductionItem? productionItem = Get.arguments;
  RxBool canEdit = true.obs;

  Rx<DesignedSari?> designedSari = Rx<DesignedSari?>(null);

  List<DesignedSari> get designedSariList =>
      Get.find<DesignedSariController>().designedSariList.value ?? [];

  @override
  void onInit() {
    super.onInit();
    quantityController =
        TextEditingController(text: productionItem?.quantity.toString() ?? '0');
    if (productionItem != null) {
      designedSari(productionItem!.designedSari);
      canEdit.value = false;
    }
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  save() async {
    try {
      int quantity = int.tryParse(quantityController.text) ?? 0;
      if (quantity > 0 && designedSari.value != null) {
        ProductionItem item = ProductionItem(
          designedSari: designedSari.value!,
          quantity: quantity,
        );

        var stockSari = await RawSariService()
            .getQuantity([designedSari.value!.rawSari!.id]);
        if ((stockSari[designedSari.value!.rawSari!.id] ?? 0) >= quantity) {
          Loading.show();
          await ProductionService().addEditProduction(item);
          await RawSariService().updateQuantity({
            designedSari.value!.rawSari!.id:
                (stockSari[designedSari.value!.rawSari!.id] ?? 0) - quantity
          });
          Loading.hide();
          Get.back();
        } else {
          Toaster.error("কাজ শুরু করার জন্য যথেষ্ট শাড়ি নাই");
        }
      }
    } catch (error) {
      Loading.hide();
      Toaster.error(error.toString());
    }
  }
}
