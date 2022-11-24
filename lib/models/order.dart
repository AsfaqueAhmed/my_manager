import 'package:my_manager/models/customer.dart';
import 'package:my_manager/models/ordered_sari.dart';
import 'package:uuid/uuid.dart';

class Order {
  String id = const Uuid().v4();
  DateTime? orderDate;
  DateTime? deliveryDate;
  DateTime? shippingDate;
  Customer customer;
  List<OrderedSari> sari;

  String? details;

  Order({
    this.orderDate,
    this.deliveryDate,
    this.shippingDate,
    this.details,
    required this.sari,
    required this.customer,
  });

  factory Order.fromJson({required Map<String, dynamic> json}) {
    return Order(
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
          ? json['sari'].map((e) => OrderedSari.fromJson(json: e)).toList()
          : null,
      details: json['details'],
      customer: Customer.fromJson(json: json['customer']),
    )..id = json['id'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderDate': orderDate?.millisecondsSinceEpoch,
        'receiveDate': deliveryDate?.millisecondsSinceEpoch,
        'shippingDate': shippingDate?.millisecondsSinceEpoch,
        'details': details,
        'customer': customer.toJson(),
        'sari': sari.map((e) => e.toJson()).toList(),
      };
}
