import 'package:get/get.dart';
import 'package:my_manager/screens/design_list/controllers/design_list_controller.dart';

import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DesignListController());
  }
}
