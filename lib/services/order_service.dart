import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/order.dart';

class OrderService {
  static OrderService? _instance;

  var collection = FirebaseFirestore.instance.collection("order");

  factory OrderService() {
    _instance ??= OrderService._();

    return _instance!;
  }

  OrderService._();

  addEditOrder(Order order) async {
    await collection.doc(order.id).set(order.toJson());
  }
}
