import 'package:get/get.dart';

import '../controllers/type_list_controller.dart';

class TypeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TypeListController>(
      () => TypeListController(),
    );
  }
}
