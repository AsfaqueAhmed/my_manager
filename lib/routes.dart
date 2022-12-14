import 'package:get/get.dart';
import 'package:my_manager/screens/customer/views/add_edit_customer_view.dart';
import 'package:my_manager/screens/customer/views/customer_view.dart';
import 'package:my_manager/screens/design/views/add_edit_design_view.dart';
import 'package:my_manager/screens/design/views/design_view.dart';
import 'package:my_manager/screens/designed_sari/views/add_edit_designed_sari_view.dart';
import 'package:my_manager/screens/home/bindings/home_binding.dart';
import 'package:my_manager/screens/home/views/home_view.dart';
import 'package:my_manager/screens/order/views/add_edit_order_view.dart';
import 'package:my_manager/screens/production/views/add_edit_production.dart';
import 'package:my_manager/screens/raw_sari/views/add_edit_raw_sari_view.dart';
import 'package:my_manager/screens/supplier/views/add_edit_supplier_view.dart';
import 'package:my_manager/screens/supplier/views/supplier_view.dart';

abstract class Routes {
  static const unknown = "/404";
  static const home = "/home";
  static const customerList = "/customer-list";
  static const addEditCustomer = "/add-customer";
  static const supplierList = "/supplier-list";
  static const addEditSupplier = "/add-supplier";
  static const addEditRawSari = "/add-raw-sari";
  static const addEditDesignedSari = "/add-designed-sari";
  static const addEditProductionItem = "/add-production-item";

  static const designList = "/design-list";
  static const addEditDesign = "/add-design";

  static const addEditOrder = "/add-order";
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
    GetPage(
      name: Routes.addEditRawSari,
      page: () => AddEditRawSariView(),
    ),
    GetPage(
      name: Routes.designList,
      page: () => DesignView(),
    ),
    GetPage(
      name: Routes.addEditDesign,
      page: () => AddEditDesignView(),
    ),
    GetPage(
      name: Routes.addEditDesignedSari,
      page: () => AddEditDesignedSariView(),
    ),
    GetPage(
      name: Routes.addEditOrder,
      page: () => AddEditOrderView(),
    ),
    GetPage(
      name: Routes.addEditProductionItem,
      page: () => AddEditProductionItem(),
    ),
  ];
}
