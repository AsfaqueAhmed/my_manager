import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleCheckerItemList<T> extends StatelessWidget {
  final CheckerItemListType checkerItemListType;
  final String title;
  final List<T> items;
  final Function(T)? getTitle;
  final Function(T)? getId;
  final T? selectedItem;
  final Function(T) onItemCheck;

  final bool enable;

  const SingleCheckerItemList({
    Key? key,
    required this.title,
    required this.items,
    required this.onItemCheck,
    this.checkerItemListType = CheckerItemListType.vertical,
    this.getTitle,
    this.selectedItem,
    this.getId,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List itemsUi = items.map((e) => _itemUiBuilder(e)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
        ...items.map((e) => _itemUiBuilder(e))
      ],
    );
  }

  _itemUiBuilder(T e) {
    return GestureDetector(
      onTap: enable ? () => onItemCheck(e) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (selectedItem != null &&
                _itemId(e) == _itemId(selectedItem as T))
              Icon(
                Icons.check_circle,
                color: Get.theme.primaryColor,
                size: 20,
              )
            else
              const Icon(
                Icons.circle_outlined,
                color: Colors.grey,
                size: 20,
              ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                _itemTitle(e),
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  dynamic _itemId(T item) => getId != null ? getId!(item) : item;

  dynamic _itemTitle(T item) =>
      getTitle != null ? getTitle!(item) : item.toString();
}

class CheckerItem {
  dynamic value;
  String title;

  CheckerItem({required this.title, this.value}) {
    value ??= title;
  }
}

enum CheckerItemListType { vertical, horizontal, wrap }
