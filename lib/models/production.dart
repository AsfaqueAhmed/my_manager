import 'package:my_manager/config/enums.dart';
import 'package:my_manager/config/extension.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:uuid/uuid.dart';

class ProductionItem {
  DesignedSari designedSari;
  int quantity;
  DateTime? startedDate;
  DateTime? completedDate;
  String id = const Uuid().v4();
  ProductionStatus status = ProductionStatus.processing;

  ProductionItem({
    required this.designedSari,
    required this.quantity,
    this.startedDate,
    this.completedDate,
    this.status = ProductionStatus.processing,
  });

  factory ProductionItem.fromJson({required Map<String, dynamic> json}) =>
      ProductionItem(
        designedSari: DesignedSari.fromJson(json: json['designedSari']),
        quantity: json['quantity'],
        startedDate: DateTime.fromMillisecondsSinceEpoch(json['startDate']),
        completedDate: json['completedDate'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['completedDate']),
        status: ProductionStatus.values.findByValue(json['status']) ??
            ProductionStatus.processing,
      )..id = json['id'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'designedSari': designedSari.toJson(),
        'quantity': quantity,
        'startDate': (startedDate ?? DateTime.now()).millisecondsSinceEpoch,
        'completedDate': completedDate?.millisecondsSinceEpoch,
        'status': status.value,
      };
}
