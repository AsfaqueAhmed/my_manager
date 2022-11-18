import 'package:my_manager/models/raw_sari.dart';
import 'package:uuid/uuid.dart';

class Design {
  String id = const Uuid().v4();
  String title;
  String? costing;
  String? details;
  List<String>? images;

  Design({
    required this.title,
    this.details,
    this.images,
    this.costing,
  });

  factory Design.fromJson({required Map<String, dynamic> json}) {
    return Design(
      title: json['title'],
      details: json['details'],
      images: json['images'] as List<String>?,
      costing: json['costing'],
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'costing': costing,
        'details': details,
        'images': images,
        'id': id,
      };
}
