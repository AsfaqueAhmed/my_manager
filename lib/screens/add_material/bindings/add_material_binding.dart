import 'package:get/get.dart';

import '../controllers/add_material_controller.dart';

class AddMaterialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMaterialController>(
      () => AddMaterialController(),
    );
  }
}
