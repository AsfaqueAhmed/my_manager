import 'package:get/get.dart';
import 'package:my_manager/screens/customer/controllers/customer_controller.dart';
import 'package:my_manager/screens/design/controllers/design_controller.dart';
import 'package:my_manager/screens/designed_sari/controllers/designed_sari_controller.dart';
import 'package:my_manager/screens/order/controllers/order_controller.dart';
import 'package:my_manager/screens/production/controllers/production_controller.dart';
import 'package:my_manager/screens/raw_sari/controllers/raw_sari_controller.dart';
import 'package:my_manager/screens/supplier/controllers/supplier_controller.dart';
import 'package:my_manager/screens/supply/controllers/supply_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<DesignController>(() => DesignController(), fenix: true);
    Get.lazyPut<SupplyController>(() => SupplyController(), fenix: true);
    Get.lazyPut<RawSariController>(() => RawSariController(), fenix: true);
    Get.lazyPut<SupplierController>(() => SupplierController(), fenix: true);
    Get.lazyPut<CustomerController>(() => CustomerController(), fenix: true);
    Get.lazyPut<ProductionController>(() => ProductionController(),
        fenix: true);
    Get.lazyPut<DesignedSariController>(() => DesignedSariController(),
        fenix: true);
  }
}
