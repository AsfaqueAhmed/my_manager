import 'package:my_manager/models/supplier.dart';
import 'package:uuid/uuid.dart';

class RawSari {
  String id = const Uuid().v4();
  String title;
  String? buyingPrice;
  String? details;
  String? material;
  String color;
  bool? tercell;

  List<String>? images;
  Supplier? source;

  int quantity = 0;

  RawSari(
      {required this.title,
      this.buyingPrice,
      this.details,
      required this.color,
      this.tercell = true,
      this.images,
      this.source,
      this.material,
      this.quantity = 0});

  factory RawSari.fromJson({required Map<String, dynamic> json}) {
    return RawSari(
      title: json['title'],
      color: json['color'],
      buyingPrice: json['buyingPrice'],
      details: json['details'],
      material: json['material'],
      tercell: json['tercell'],
      source: json['source'] is Map<String, dynamic>
          ? Supplier.fromJson(json: json['source'])
          : null,
      images: json['images'] as List<String>?,
      quantity: json['quantity'],
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'color': color,
        'material': material,
        'buyingPrice': buyingPrice,
        'details': details,
        'tercell': tercell,
        'source': source?.toJson(),
        'images': images,
        'id': id,
        'quantity': quantity,
      };
}
