import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/production.dart';

class ProductionService {
  static ProductionService? _instance;

  var collection = FirebaseFirestore.instance.collection("production");

  factory ProductionService() {
    _instance ??= ProductionService._();

    return _instance!;
  }

  ProductionService._();

  addEditProduction(ProductionItem item) async {
    await collection.doc(item.id).set(item.toJson());
  }
}
