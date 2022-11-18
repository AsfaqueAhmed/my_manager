import 'package:my_manager/models/raw_sari.dart';
import 'package:uuid/uuid.dart';

class Source {
  String id = const Uuid().v4();
  String title;
  String? details;
  String? mobileNumber;
  List<String>? images;

  Source({
    required this.title,
    this.details,
    this.images,
    this.mobileNumber,
  });

  factory Source.fromJson({required Map<String, dynamic> json}) {
    return Source(
      title: json['title'],
      details: json['details'],
      mobileNumber: json['mobileNumber'],
      images: json['images'] as List<String>?,
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'details': details,
        'images': images,
        'mobileNumber': mobileNumber,
        'id': id,
      };
}
