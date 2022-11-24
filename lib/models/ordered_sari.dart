import 'package:my_manager/models/designed_sari.dart';

class OrderedSari {
  DesignedSari designedSari;
  int quantity;
  int unitPrice;

  OrderedSari({
    required this.designedSari,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderedSari.fromJson({required Map<String, dynamic> json}) =>
      OrderedSari(
        designedSari: DesignedSari.fromJson(json: json['designedSari']),
        quantity: json['quantity'],
        unitPrice: json['unitPrice'],
      );

  Map<String, dynamic> toJson() => {
        'designedSari': designedSari.toJson(),
        'quantity': quantity,
        'unitPrice': unitPrice
      };
}
