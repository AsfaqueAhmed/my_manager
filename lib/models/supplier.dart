import 'package:my_manager/models/raw_sari.dart';
import 'package:uuid/uuid.dart';

class Supplier {
  String id = const Uuid().v4();
  String name;
  String? details;
  String? address;
  String? mobileNumber;
  List<String>? images;

  Supplier({
    required this.name,
    this.details,
    this.images,
    this.mobileNumber,
    this.address,
  });

  factory Supplier.fromJson({required Map<String, dynamic> json}) {
    return Supplier(
      name: json['title'],
      details: json['details'],
      address: json['address'],
      mobileNumber: json['mobileNumber'],
      images: json['images'] as List<String>?,
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': name,
        'details': details,
        'images': images,
        'mobileNumber': mobileNumber,
        'address': address,
        'id': id,
      };
}
