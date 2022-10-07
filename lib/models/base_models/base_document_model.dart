import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class BaseDocumentModel {
  late String id;

  @mustCallSuper
  BaseDocumentModel({required this.id});

  @mustCallSuper
  BaseDocumentModel.fromDocument(DocumentReference documentRefs) {
    id = documentRefs.id;
  }

  Map<String, dynamic> toJson();
}
