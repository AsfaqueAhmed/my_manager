import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/customer.dart';

class CustomerService {
  static CustomerService? _instance;

  var collection = FirebaseFirestore.instance.collection("customer");

  factory CustomerService() {
    _instance ??= CustomerService._();

    return _instance!;
  }

  CustomerService._();

  addCustomer(Customer customer) async{
    await collection.doc(customer.id).set(customer.toJson());
  }
}
