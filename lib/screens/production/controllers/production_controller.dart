import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/config/enums.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/models/production.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/designed_sari_service.dart';
import 'package:my_manager/services/production_service.dart';
import 'package:my_manager/widget/custom_picker.dart';

class ProductionController extends GetxController {
  late StreamSubscription _streamSubscription;

  Rx<List<ProductionItem>?> productionList = Rx(null);
  Rx<ProductionStatus> selectedTab = Rx(ProductionStatus.processing);

  var designedSariCollection = ProductionService().collection;

  @override
  void onInit() {
    super.onInit();
    _startListening();
  }

  @override
  void dispose() {
    _closeListening();
    super.dispose();
  }

  void navigateToAddProduction() {
    Get.toNamed(Routes.addEditProductionItem);
  }

  switchTab(ProductionStatus status) {
    productionList.value = [];
    _closeListening();
    selectedTab(status);
    _startListening();
  }

  void _startListening() {
    _streamSubscription = designedSariCollection
        .where('status', isEqualTo: selectedTab.value.value)
        .orderBy("completedDate")
        .snapshots()
        .listen((snapShot) {
      productionList.value = [];
      if (snapShot.size > 0) {
        productionList.value = snapShot.docs
            .map((e) => ProductionItem.fromJson(json: e.data()))
            .toList();
      }
    });
  }

  Future<void> _closeListening() => _streamSubscription.cancel();

  void showProductionStatusChangeDialog(ProductionItem item) {
    CustomPickerController.show<ProductionStatus>(
      title: "অর্ডার স্ট্যাটাস পরিবর্তন",
      items: ProductionStatus.values,
      selectedType: item.status,
      getTitle: (status) => status.value,
      getId: (status) => status.value,
    ).then((status) {
      ProductionStatus previousStatus = item.status;
      if (status == null || status.index <= previousStatus.index) return;
      DesignedSariService().getQuantity([item.designedSari.id]).then((value) {
        DesignedSariService().updateQuantity({
          item.designedSari.id: value[item.designedSari.id]! + item.quantity,
        });
        item.status = status;
        ProductionService().addEditProduction(item);
      });
    });
  }
}
