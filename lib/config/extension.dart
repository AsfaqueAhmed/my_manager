import 'package:flutter/material.dart';
import 'package:my_manager/config/colors.dart';
import 'package:my_manager/config/enums.dart';

extension DateToString on DateTime {
  String get formattedDate => '$day/$month/$year';
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
  Widget getUi() => Container(
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

  Color get color => this == OrderStatus.pending
      ? AppColors.warning
      : this == OrderStatus.canceled
          ? AppColors.error
          : this == OrderStatus.send
              ? AppColors.success
              : AppColors.other;
}
