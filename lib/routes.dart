import 'package:get/get.dart';
import 'package:my_manager/screens/add_design/bindings/add_design_binding.dart';
import 'package:my_manager/screens/add_design/ui/add_design_view.dart';
import 'package:my_manager/screens/add_product/bindings/add_product_binding.dart';
import 'package:my_manager/screens/add_product/ui/add_product_view.dart';
import 'package:my_manager/screens/home/binding/home_binding.dart';
import 'package:my_manager/screens/home/ui/home_screen.dart';

abstract class Routes {
  static String home = "/home";
  static String addDesign = "/add_design";
  static String addProduct = "/add_product";
}

abstract class Pages {
  static var routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.addDesign,
      page: () => const AddDesignView(),
      binding: AddDesignBinding(),
    ),
    GetPage(
      name: Routes.addProduct,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
  ];
}
