import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/models/raw_sari.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/raw_sari_service.dart';

class RawSariController extends GetxController {
  late StreamSubscription _streamSubscription;

  Rx<List<RawSari>?> rawSariList = Rx(null);

  var rawSariCollection = RawSariService().collection;

  @override
  void onInit() {
    super.onInit();
    _streamSubscription =
        rawSariCollection.orderBy("quantity",descending: true).snapshots().listen((snapShot) {
      rawSariList.value = [];
      if (snapShot.size > 0) {
        rawSariList.value =
            snapShot.docs.map((e) => RawSari.fromJson(json: e.data())).toList();
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void navigateToAddRawSari() {
    Get.toNamed(Routes.addEditRawSari);
  }

  showRawSariDetails(RawSari sari) {
    Get.toNamed(Routes.addEditRawSari, arguments: sari);
  }
}
