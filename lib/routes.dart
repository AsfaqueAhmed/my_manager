import 'package:get/get.dart';
import 'package:my_manager/screens/customer/views/add_edit_customer_view.dart';
import 'package:my_manager/screens/customer/views/customer_view.dart';
import 'package:my_manager/screens/home/bindings/home_binding.dart';
import 'package:my_manager/screens/home/views/home_view.dart';
import 'package:my_manager/screens/supplier/views/add_edit_supplier_view.dart';
import 'package:my_manager/screens/supplier/views/supplier_view.dart';

abstract class Routes {
  static const unknown = "/404";
  static const home = "/home";
  static const customerList = "/customer-list";
  static const addEditCustomer = "/add-customer";
  static const supplierList = "/supplier-list";
  static const addEditSupplier = "/add-supplier";
}

abstract class Pages {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.customerList,
      page: () => CustomerView(),
    ),
    GetPage(
      name: Routes.addEditCustomer,
      page: () => AddEditCustomerView(),
    ),
    GetPage(
      name: Routes.supplierList,
      page: () => SupplierView(),
    ),
    GetPage(
      name: Routes.addEditSupplier,
      page: () => AddEditSupplierView(),
    ),
  ];
}
