import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_manager/firebase_options.dart';

import '../models/base_models/base_document_model.dart';

class FirebaseService extends GetxService {
  init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  CollectionReference getCollectionReference<T extends BaseDocumentModel>() {
    return FirebaseFirestore.instance.collection(T.runtimeType.toString());
  }

  DocumentReference getDocument<T extends BaseDocumentModel>(String id) {
    return FirebaseFirestore.instance.doc("${T.runtimeType.toString()}/$id");
  }
}
