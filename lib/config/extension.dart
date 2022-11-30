import 'package:flutter/material.dart';
import 'package:my_manager/config/colors.dart';
import 'package:my_manager/config/enums.dart';

extension DateToString on DateTime {
  String get formattedDate =>
      '$day/$month/$year @${(hour % 12 == 0 ? 12 : hour % 12).padded()}:${minute.padded()} ${hour >= 12 ? "PM" : "AM"}';
}

extension PaddedInt on int {
  padded([int length = 2]) => toString().padLeft(length, '0');
}

extension Value on Enum {
  String get value => name;
}

extension Search<T extends Enum> on List<T> {
  T? find(int? value) {
    return findByIndex(value);
  }

  T? findByValue(String? value) {
    return findByName(value);
  }

  T? findByName(String? name) {
    if (name == null) return null;
    return firstWhere((element) => element.name == name);
  }

  T? findByIndex(int? index) {
    if (index == null) return null;
    return firstWhere((element) => element.index == index);
  }
}

extension Ui on OrderStatus {
  Widget getUi() => _container(value, color);

  Color get color => this == OrderStatus.pending
      ? AppColors.warning
      : this == OrderStatus.canceled
          ? AppColors.error
          : this == OrderStatus.send
              ? AppColors.success
              : AppColors.other;
}

extension UiProductionStatus on ProductionStatus {
  Widget getUi() => _container(value, color);

  Color get color => this == ProductionStatus.processing
      ? AppColors.warning
      : this == ProductionStatus.done
          ? AppColors.success
          : AppColors.other;
}

Container _container(String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 1,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: color,
    ),
    child: Text(
      value,
      style: const TextStyle(
        fontSize: 10,
        color: Colors.white,
      ),
    ),
  );
}
