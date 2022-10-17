import 'package:get/get.dart';

import '../controllers/add_type_controller.dart';

class AddTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTypeController>(
      () => AddTypeController(),
    );
  }
}
