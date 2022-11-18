import 'package:get/get.dart';
import 'package:my_manager/screens/designed_sari/controllers/designed_sari_controller.dart';
import 'package:my_manager/screens/designed_sari/views/designed_sari_view.dart';
import 'package:my_manager/screens/order/controllers/order_controller.dart';
import 'package:my_manager/screens/raw_sari/controllers/raw_sari_controller.dart';
import 'package:my_manager/screens/raw_sari/views/raw_sari_view.dart';
import 'package:my_manager/screens/supply/controllers/supply_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<SupplyController>(() => SupplyController());
    Get.lazyPut<RawSariController>(() => RawSariController());
    Get.lazyPut<DesignedSariController>(() => DesignedSariController());
  }
}
