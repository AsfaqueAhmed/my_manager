import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/supplier_service.dart';

class SupplierController extends GetxController {

  late StreamSubscription _streamSubscription;

  Rx<List<Supplier>?> supplierList = Rx(null);

  var supplierCollection = SupplierService().collection;

  @override
  void onInit() {
    super.onInit();
    _streamSubscription =
        supplierCollection.orderBy("title").snapshots().listen((snapShot) {
          supplierList.value=[];
          if (snapShot.size > 0) {
            supplierList.value = snapShot.docs
                .map((e) => Supplier.fromJson(json: e.data()))
                .toList();
          }
        });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  navigateToAddNewSupplier() => Get.toNamed(Routes.addEditSupplier);
}
