import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/raw_sari.dart';

class RawSariService {
  static RawSariService? _instance;

  var collection = FirebaseFirestore.instance.collection("raw_sari");

  factory RawSariService() {
    _instance ??= RawSariService._();

    return _instance!;
  }

  RawSariService._();

  addNewSari(RawSari rawSari) async {
    await collection.doc(rawSari.id).set(rawSari.toJson());
  }

  Future<Map<String, int>> getQuantity(List<String> sariIds) async {
    QuerySnapshot<Map<String, dynamic>> designedSari =
        await collection.where('id', whereIn: sariIds).get();

    Map<String, int> quantities = {};
    for (var element in sariIds) {
      quantities[element] = 0;
    }

    if (designedSari.size == 0) {
      return quantities;
    }

    for (var element in designedSari.docs) {
      quantities[element['id']] = element['quantity'];
    }

    return quantities;
  }
  Future updateQuantity(Map<String, int> updatedQuantity) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    WriteBatch batch = db.batch();
    updatedQuantity.forEach((key, value) {
      batch.update(collection.doc(key), {'quantity': value});
    });
    await batch.commit();
  }
}
