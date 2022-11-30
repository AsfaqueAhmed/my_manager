import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/config/enums.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/models/order.dart';
import 'package:my_manager/models/ordered_sari.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/screens/designed_sari/component/designed_raw_sari_title.dart';
import 'package:my_manager/services/designed_sari_service.dart';
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
    ).then((status) => _switchStatus(order, status));
  }

  Future _switchStatus(Order order, OrderStatus? status) async {
    OrderStatus previousStatus = order.status;
    if (status == null || status.index <= previousStatus.index) return;

    List<OrderedSari> orderedSariList = [];
    List<String> designedSariIdList = [];
    for (var sari in order.sari) {
      orderedSariList.add(sari);
      designedSariIdList.add(sari.designedSari.id);
    }
    switch (status) {
      case OrderStatus.pending:

        break;
      case OrderStatus.processing:
        break;
      case OrderStatus.send:
        Map<String, int> inStockDesignedSari =
            await DesignedSariService().getQuantity(designedSariIdList);

        List<DesignedSari> sarisToProcess = [];
        for (var element in orderedSariList) {
          if (element.quantity >
              (inStockDesignedSari[element.designedSari.id] ?? 0)) {
            sarisToProcess.add(element.designedSari
              ..quantity = element.quantity -
                  (inStockDesignedSari[element.designedSari.id] ?? 0));
          }
        }
        if (sarisToProcess.isEmpty) {
          order.deliveryDate = DateTime.now();
          Map<String, int> updatedQuantity = {};
          for (var element in orderedSariList) {
            updatedQuantity[element.designedSari.id] =
                inStockDesignedSari[element.designedSari.id]! -
                    element.quantity;
          }
          await DesignedSariService().updateQuantity(updatedQuantity);
        } else {
          _showDialogWithRequiredDesignedProductList(sarisToProcess);
          return;
        }
        break;
      case OrderStatus.canceled:
        break;
    }

    order.status = status;
    OrderService().addEditOrder(order);
  }

  void _showDialogWithRequiredDesignedProductList(
    List<DesignedSari> sarisToProcess,
  ) {
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xffE0E0E0), width: 1),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: const [
                  Text(
                    "নিচের শাড়ি গুলো আগে রেডি করুণ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: sarisToProcess.length,
                itemBuilder: (context, index) =>
                    DesignedSariTile(sari: sarisToProcess[index]),
              ),
            )
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor);
  }
}
