import 'package:my_manager/models/raw_sari.dart';
import 'package:uuid/uuid.dart';

class Customer {
  String id = const Uuid().v4();
  String name;
  String? mobileNumber;
  String? address;
  String? details;
  List<String>? images;

  Customer({
    required this.name,
    this.details,
    this.mobileNumber,
    this.address,
    this.images,
  });

  factory Customer.fromJson({required Map<String, dynamic> json}) {
    return Customer(
      name: json['title'],
      details: json['details'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      images: json['images'] as List<String>?,
    )..id = json['id'];
  }


  Map<String, dynamic> toJson() => {
        'title': name,
        'details': details,
        'mobileNumber': mobileNumber,
        'address': address,
        'images': images,
        'id': id,
      };
}
