import 'dart:async';

import 'package:get/get.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/services/customer_service.dart';

class CustomerController extends GetxController {
  late StreamSubscription _streamSubscription;

  Rx<List<Customer>?> customerList = Rx(null);

  var customerCollection = CustomerService().collection;

  @override
  void onInit() {
    super.onInit();
    _streamSubscription =
        customerCollection.orderBy("title").snapshots().listen((snapShot) {
      if (snapShot.size > 0) {
        customerList.value = snapShot.docs
            .map((e) => Customer.fromJson(json: e.data()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  navigateToAddNewCustomer() => Get.toNamed(Routes.addEditCustomer);
}
