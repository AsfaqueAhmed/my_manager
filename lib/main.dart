import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/screens/404/ui/404.dart';
import 'package:my_manager/services/design_service.dart';
import 'package:my_manager/services/firebase_services.dart';
import 'package:my_manager/services/order_service.dart';
import 'package:my_manager/services/product_service.dart';
import 'package:my_manager/utility/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();

  runApp(
    GetMaterialApp(
      color: LightThemeColor.primaryColor,
      theme: LightThemeColor.theme,
      initialRoute: Routes.home,
      getPages: Pages.routes,
      unknownRoute: GetPage(
        name: Routes.unknown,
        page: () => const NotFound404(),
      ),
    ),
  );
}

void initServices() async {
  await Get.put(FirebaseService()).init();
  GetStorage.init();
  Get.lazyPut(() => ProductService());
  Get.lazyPut(() => OrderService());
  Get.lazyPut(() => DesignService());
}
