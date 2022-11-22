import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/raw_sari.dart';

class RawSariService {
  static RawSariService? _instance;

  var collection = FirebaseFirestore.instance.collection("raw_sari");

  factory RawSariService() {
    _instance ??= RawSariService._();

    return _instance!;
  }

  RawSariService._();

  addNewSari(RawSari rawSari) async{
    await collection.doc(rawSari.id).set(rawSari.toJson());
  }
}
