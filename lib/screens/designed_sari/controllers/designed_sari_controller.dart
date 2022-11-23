import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/designed_sari_service.dart';

class DesignedSariController extends GetxController {
  late StreamSubscription _streamSubscription;

  Rx<List<DesignedSari>?> designedSariList = Rx(null);

  var designedSariCollection = DesignedSariService().collection;

  @override
  void onInit() {
    super.onInit();
    _streamSubscription =
        designedSariCollection.orderBy("title").snapshots().listen((snapShot) {
      designedSariList.value = [];
      if (snapShot.size > 0) {
        designedSariList.value = snapShot.docs
            .map((e) => DesignedSari.fromJson(json: e.data()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void navigateToAddDesignedSari() {
    Get.toNamed(Routes.addEditDesignedSari);
  }

  showDesignedSariDetails(DesignedSari sari) {
    Get.toNamed(Routes.addEditDesignedSari, arguments: sari);
  }
}
