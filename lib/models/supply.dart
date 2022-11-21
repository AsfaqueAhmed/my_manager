import 'package:my_manager/models/raw_sari.dart';
import 'package:my_manager/models/supplier.dart';
import 'package:uuid/uuid.dart';

class Supply {
  String id = const Uuid().v4();
  String title;
  Supplier? source;
  DateTime? orderDate;
  DateTime? receiveDate;
  bool received = false;
  List<RawSari>? rawSaris = [];
  Map<String, int>? rawSarisCount = {};

  Supply({
    required this.title,
    this.source,
    this.orderDate,
    this.receiveDate,
    this.received = false,
    this.rawSaris,
    this.rawSarisCount,
  });

  factory Supply.fromJson({required Map<String, dynamic> json}) {
    return Supply(
      title: json['title'],
      source: json['source'] is Map<String, dynamic>
          ? Supplier.fromJson(json: json['source'])
          : null,
      orderDate: json['orderDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['orderDate'])
          : null,
      receiveDate: json['receiveDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['receiveDate'])
          : null,
      rawSaris: json['rawSaris'] is List<Map<String, dynamic>>
          ? json['rawSaris']
              .map((element) => RawSari.fromJson(json: element))
              .toList()
          : null,
      rawSarisCount: json['rawSarisCount'],
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'source': source?.toJson(),
        'orderDate': orderDate?.millisecondsSinceEpoch,
        'receiveDate': receiveDate?.millisecondsSinceEpoch,
        'rawSaris': rawSaris?.map((e) => e.toJson())?.toList(),
        'rawSarisCount': rawSarisCount,
      };
}
