import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/models/raw_sari.dart';

class DesignedSariService {
  static DesignedSariService? _instance;

  var collection = FirebaseFirestore.instance.collection("designed_sari");

  factory DesignedSariService() {
    _instance ??= DesignedSariService._();

    return _instance!;
  }

  DesignedSariService._();

  addNewSari(DesignedSari designedSari) async{
    await collection.doc(designedSari.id).set(designedSari.toJson());
  }
}
