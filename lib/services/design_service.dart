import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_manager/models/design.dart';

class DesignService {
  static DesignService? _instance;

  var collection = FirebaseFirestore.instance.collection("design");

  factory DesignService() {
    _instance ??= DesignService._();

    return _instance!;
  }

  DesignService._();

  addDesign(Design design) async {
    await collection.doc(design.id).set(design.toJson());
  }
}
