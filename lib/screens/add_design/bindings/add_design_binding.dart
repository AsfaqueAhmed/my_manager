import 'package:get/get.dart';

import '../controllers/add_design_controller.dart';

class AddDesignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDesignController>(
      () => AddDesignController(),
    );
  }
}
