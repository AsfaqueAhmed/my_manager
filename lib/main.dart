import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_manager/routes.dart';
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
      theme: ThemeData.light(useMaterial3: true).copyWith(
        primaryColor: LightThemeColor.primaryColor,
        appBarTheme: const AppBarTheme(color: LightThemeColor.primaryColor),
      ),
      initialRoute: Routes.home,
      getPages: Pages.routes,
    ),
  );
}

void initServices() async {
  await Get.put(FirebaseService()).init();
  GetStorage.init("my_manager");
  Get.lazyPut(() => ProductService());
  Get.lazyPut(() => OrderService());
  Get.lazyPut(() => DesignService());
}
