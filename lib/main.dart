import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_manager/routes.dart';
import 'package:my_manager/screens/404/ui/404.dart';
import 'package:my_manager/services/firebase_services.dart';
import 'package:my_manager/config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

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

initServices() async {
  await FirebaseService().init();
  GetStorage.init();
}
