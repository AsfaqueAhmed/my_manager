import 'package:get/get.dart';
import 'package:my_manager/screens/404/ui/404.dart';
import 'package:my_manager/screens/add_material/bindings/add_material_binding.dart';
import 'package:my_manager/screens/add_material/views/add_material_view.dart';
import 'package:my_manager/screens/add_type/bindings/add_type_binding.dart';
import 'package:my_manager/screens/add_type/views/add_type_view.dart';
import 'package:my_manager/screens/home/binding/home_binding.dart';
import 'package:my_manager/screens/home/ui/home_screen.dart';
import 'package:my_manager/screens/type_list/bindings/type_list_binding.dart';
import 'package:my_manager/screens/type_list/views/type_list_view.dart';

abstract class Routes {
  static const home = "/home";
  static const unknown = "/404";
  static const typeList = '/type-list';

  static const addType = '/add-type';
  static const addDesign = "/add_design";
  static const addProduct = "/add_product";
  static const addMaterial = '/add-material';
}

abstract class Pages {
  static var routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.unknown,
      page: () => const NotFound404(),
    ),
    GetPage(
      name: Routes.addMaterial,
      page: () => const AddMaterialView(),
      binding: AddMaterialBinding(),
    ),
    GetPage(
      name: Routes.addType,
      page: () => const AddTypeView(),
      binding: AddTypeBinding(),
    ),
    GetPage(
      name: Routes.typeList,
      page: () => const TypeListView(),
      binding: TypeListBinding(),
    ),
  ];
}
