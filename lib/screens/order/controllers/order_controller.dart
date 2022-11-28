import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/config/enums.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/models/order.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/order_service.dart';
import 'package:my_manager/widget/custom_picker.dart';

class OrderController extends GetxController {
  late StreamSubscription _streamSubscription;

  Rx<List<Order>?> orderList = Rx(null);

  var orderCollection = OrderService().collection;

  Rx<OrderStatus> selectedTab = Rx(OrderStatus.pending);

  @override
  void onInit() {
    super.onInit();
    startListening();
  }

  @override
  void dispose() {
    closeListening();
    super.dispose();
  }

  void navigateToAddOrder() {
    Get.toNamed(Routes.addEditOrder);
  }

  showOrderDetails(Order order) {
    Get.toNamed(Routes.addEditOrder, arguments: order);
  }

  void startListening() {
    _streamSubscription = orderCollection
        .where('status', isEqualTo: selectedTab.value.value)
        .snapshots()
        .listen((snapShot) {
      orderList.value = [];
      if (snapShot.size > 0) {
        orderList.value =
            snapShot.docs.map((e) => Order.fromJson(json: e.data())).toList();
      }
    });
  }

  closeListening() async => await _streamSubscription.cancel();

  switchTab(OrderStatus status) async {
    orderList([]);
    await closeListening();
    selectedTab(status);

    startListening();
  }

  void showOrderStatusChangeDialog(Order order) {
    CustomPickerController.show<OrderStatus>(
      title: "অর্ডার স্ট্যাটাস পরিবর্তন",
      items: OrderStatus.values,
      selectedType: order.status,
      getTitle: (status) => status.value,
      getId: (status) => status.value,
    ).then((value) {
      order.status = value;
      if (value == OrderStatus.send) {
        order.deliveryDate = DateTime.now();
      }
      OrderService().updateOrder(order);
    });
  }
}
