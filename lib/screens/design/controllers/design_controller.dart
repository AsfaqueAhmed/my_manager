import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/models/design.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/design_service.dart';

class DesignController extends GetxController {
  late StreamSubscription _streamSubscription;

  Rx<List<Design>?> designList = Rx(null);

  var rawSariCollection = DesignService().collection;

  @override
  void onInit() {
    super.onInit();
    _streamSubscription =
        rawSariCollection.orderBy("title").snapshots().listen((snapShot) {
      designList.value = [];
      if (snapShot.size > 0) {
        designList.value =
            snapShot.docs.map((e) => Design.fromJson(json: e.data())).toList();
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void navigateToAddDesign() {
    Get.toNamed(Routes.addEditDesign);
  }

  showDesignDetails(Design design) {
    Get.toNamed(Routes.addEditDesign, arguments: design);
  }
}
