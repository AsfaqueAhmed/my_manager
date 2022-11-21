import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/supplier.dart';

class SupplierService {
  static SupplierService? _instance;

  var collection = FirebaseFirestore.instance.collection("supplier");

  factory SupplierService() {
    _instance ??= SupplierService._();

    return _instance!;
  }

  SupplierService._();

  addSupplier(Supplier supplier) async{
    await collection.doc(supplier.id).set(supplier.toJson());
  }
}
