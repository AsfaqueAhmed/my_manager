import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:uuid/uuid.dart';

class Order {
  String id = const Uuid().v4();
  String title;
  DateTime? orderDate;
  DateTime? deliveryDate;
  DateTime? shippingDate;
  Customer customer;
  List<DesignedSari>? sari;

  Order({
    required this.title,
    this.orderDate,
    this.deliveryDate,
    this.shippingDate,
    this.sari,
    required this.customer,
  });

  factory Order.fromJson({required Map<String, dynamic> json}) {
    return Order(
      title: json['title'],
      orderDate: json['orderDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['orderDate'])
          : null,
      deliveryDate: json['receiveDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['receiveDate'])
          : null,
      shippingDate: json['shippingDate'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['shippingDate'])
          : null,
      sari: json['sari'] is List<Map<String, dynamic>>
          ? json['sari'].map((e) => DesignedSari.fromJson(json: e)).toList()
          : null,
      customer: Customer.fromJson(json: json['customer']),
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'orderDate': orderDate?.millisecondsSinceEpoch,
        'receiveDate': deliveryDate?.millisecondsSinceEpoch,
        'shippingDate': shippingDate?.millisecondsSinceEpoch,
        'customer': customer.toJson(),
      };
}
