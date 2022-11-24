import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/models/order.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/order_service.dart';

class OrderController extends GetxController {
  late StreamSubscription _streamSubscription;

  Rx<List<Order>?> designedSariList = Rx(null);

  var designedSariCollection = OrderService().collection;

  @override
  void onInit() {
    super.onInit();
    _streamSubscription =
        designedSariCollection.orderBy("title").snapshots().listen((snapShot) {
      designedSariList.value = [];
      if (snapShot.size > 0) {
        designedSariList.value =
            snapShot.docs.map((e) => Order.fromJson(json: e.data())).toList();
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void navigateToAddOrder() {
    Get.toNamed(Routes.addEditOrder);
  }

  showOrderDetails(Order order) {
    Get.toNamed(Routes.addEditOrder, arguments: order);
  }
}
