import 'package:get/get.dart';
import 'package:my_manager/screens/home/bindings/home_binding.dart';
import 'package:my_manager/screens/home/views/home_view.dart';

abstract class Routes {
  static const unknown = "/404";
  static const home = "/home";
}

abstract class Pages {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
