import 'package:uuid/uuid.dart';

class RawSari {
  String id = const Uuid().v4();
  String title;
  String? buyingPrice;
  String? details;
  String color;
  bool? tercell;

  List<String>? images;
  String? source;

  int quantity=0;

  RawSari({
    required this.title,
    this.buyingPrice,
    this.details,
    required this.color,
    this.tercell = true,
    this.images,
    this.source,
  });

  factory RawSari.fromJson({required Map<String, dynamic> json}) {
    return RawSari(
      title: json['title'],
      color: json['color'],
      buyingPrice: json['buyingPrice'],
      details: json['details'],
      tercell: json['tercell'],
      source: json['source'],
      images: json['images'] as List<String>?,
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'color': color,
        'buyingPrice': buyingPrice,
        'details': details,
        'tercell': tercell,
        'source': source,
        'images': images,
        'id': id,
      };
}
