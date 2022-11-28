import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/models/order.dart';
import 'package:my_manager/models/ordered_sari.dart';
import 'package:my_manager/screens/order/components/customer_picker.dart';
import 'package:my_manager/screens/order/components/order_item_quantity_price_update_ui.dart';
import 'package:my_manager/services/customer_service.dart';
import 'package:my_manager/services/order_service.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/utility/toaster.dart';

class AddEditOrderController extends GetxController {
  late TextEditingController customerNameController,
      customerNumberController,
      customerAddressController,
      detailsController;

  var orderedSari = Rx<List<OrderedSari>>([]);

  Order? order = Get.arguments;
  RxBool canEdit = true.obs;

  Rx<Customer?> selectedCustomer = Rx(null);

  @override
  void onInit() {
    super.onInit();
    customerNameController = TextEditingController(text: order?.customer.name);
    customerNumberController =
        TextEditingController(text: order?.customer.mobileNumber);
    customerAddressController =
        TextEditingController(text: order?.customer.address);
    detailsController = TextEditingController(text: order?.details);
    canEdit.value = (order == null);
    orderedSari.value = order?.sari ?? [];
  }

  @override
  void dispose() {
    customerNameController.dispose();
    customerNumberController.dispose();
    customerAddressController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  save() async {
    if (customerNameController.text.isEmpty ||
        customerNumberController.text.isEmpty ||
        orderedSari.value.isEmpty) return;
    try {
      var customer = selectedCustomer.value ??
          Customer(
            name: customerNameController.text,
            mobileNumber: customerNumberController.text,
            address: customerAddressController.text,
          );

      Order order = Order(
        sari: orderedSari.value,
        customer: customer,
        details: detailsController.text,
      );
      if (this.order != null) {
        order.id = this.order!.id;
      }

      Loading.show();
      if (selectedCustomer.value == null) {
        await CustomerService().addCustomer(customer);
      }

      await OrderService().updateOrder(order);
      Loading.hide();
      Get.back();
      Toaster.success("শাড়ি সংযোজন সফল");
    } catch (error) {
      Loading.hide();
      Toaster.error(error.toString());
    }
  }

  void onNewItemAdd(DesignedSari sari) {
    if (orderedSari.value
        .any((element) => element.designedSari.id == sari.id)) {
      orderedSari.update((val) {
        OrderedSari orderedSari =
            val!.firstWhere((element) => element.designedSari.id == sari.id);
        orderedSari.quantity++;
      });
    } else {
      orderedSari.update((val) {
        val!.add(OrderedSari(designedSari: sari, quantity: 1, unitPrice: 950));
      });
    }
  }

  onRemoveOrderedSari(OrderedSari sari) {
    orderedSari.update((val) {
      val!.remove(sari);
    });
  }

  onEditOrderedSari(OrderedSari sari) {
    Get.dialog(OrderedItemQuantityPriceUpdate(orderedSari: sari))
        .then((result) {
      if (result != null) {
        orderedSari.update((val) {
          OrderedSari orderedSari = val!.firstWhere(
              (element) => element.designedSari.id == sari.designedSari.id);
          orderedSari.quantity = result['quantity'];
          orderedSari.unitPrice = result['price'];
        });
      }
    });
  }

  selectCustomer() {
    Get.bottomSheet(CustomerPicker(customer: selectedCustomer.value))
        .then((result) {
      if (result is Customer) {
        selectedCustomer.value = result;
        customerNameController.text = result.name;
        customerNumberController.text = result.mobileNumber ?? '';
        customerAddressController.text = result.address ?? '';
      }
      if (result is String) {
        selectedCustomer.value = null;
        customerNameController.text = result;
        customerNumberController.text = '';
        customerAddressController.text = '';
      }
    });
  }
}
