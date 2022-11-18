import 'package:my_manager/models/design.dart';
import 'package:my_manager/models/raw_sari.dart';
import 'package:uuid/uuid.dart';

class DesignedSari {
  String id = const Uuid().v4();
  String title;
  String? costing;
  String? details;
  List<String>? images;
  int quantity = 0;
  RawSari? rawSari;
  Design? design;

  DesignedSari({
    required this.title,
    this.details,
    this.images,
    this.quantity = 0,
    this.costing,
    this.rawSari,
    this.design,
  });

  factory DesignedSari.fromJson({required Map<String, dynamic> json}) {
    return DesignedSari(
      title: json['title'],
      details: json['details'],
      images: json['images'] as List<String>?,
      quantity: json['quantity'],
      costing: json['costing'],
      rawSari: json['rawSari'] is Map<String, dynamic>
          ? RawSari.fromJson(json: json['rawSari'])
          : null,
      design: json['design'] is Map<String, dynamic>
          ? Design.fromJson(json: json['design'])
          : null,
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'costing': costing,
        'details': details,
        'rawSari': rawSari?.toJson(),
        'design': design?.toJson(),
        'images': images,
        'id': id,
        'quantity': quantity,
      };
}
