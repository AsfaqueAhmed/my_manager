import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'picker_item.dart';
import 'text_input_widget.dart';

abstract class CustomPickerController {
  static Future show<T>({
    required String title,
    required List<T> items,
    T? selectedType,
    String Function(T)? getTitle,
    String Function(T)? getSubTitle,
    String Function(T)? getId,
    TextEditingController? searchController,
  }) {
    return Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xffE0E0E0), width: 1),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            if (searchController != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16) +
                    const EdgeInsets.only(top: 20),
                child: TextInputWidget(
                  controller: searchController,
                  hint: "সার্চ",
                ),
              ),
            if (searchController == null)
              Expanded(
                child: _listView<T>(
                  items,
                  selectedType,
                  getTitle,
                  getSubTitle,
                  getId,
                ),
              )
            else
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: searchController,
                    builder: (context, value, child) {
                      var list = items
                          .where(
                            (e) => (getTitle == null
                                    ? e.toString()
                                    : getTitle(e!))
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()),
                          )
                          .toList();
                      return _listView<T>(
                        list,
                        selectedType,
                        getTitle,
                        getSubTitle,
                        getId,
                      );
                    }),
              ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor);
  }

  static ListView _listView<T>(
    List<T> list,
    selectedType,
    String Function(T)? getTitle,
    String Function(T)? getSubTitle,
    String Function(T)? getId,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 8),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        String title = (getTitle == null ? item.toString() : getTitle(item!));
        return GestureDetector(
          onTap: () {
            Navigator.pop(context, item);
          },
          child: PickerItem2(
            title: title,
            subTitle: getSubTitle == null ? null : getSubTitle(item),
            isSelected: selectedType != null &&
                (getId == null
                    ? item == selectedType
                    : getId(item) == getId(selectedType)),
          ),
        );
      },
    );
  }
}

abstract class CustomPickerWithCustomUiController {
  static Future show<T>({
    required String title,
    required List<T> items,
    String Function(T)? getTitle,
    TextEditingController? searchController,
    T? selectedType,
  }) {
    return Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xffE0E0E0), width: 1),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            if (searchController != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16) +
                    const EdgeInsets.only(top: 20),
                child: TextInputWidget(
                  controller: searchController,
                  hint: "সার্চ",
                ),
              ),
            if (searchController == null)
              Expanded(
                child: _listView<T>(
                  items,
                  selectedType,
                ),
              )
            else
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: searchController,
                    builder: (context, value, child) {
                      var list = items
                          .where(
                            (e) => (getTitle == null
                                    ? e.toString()
                                    : getTitle(e!))
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase()),
                          )
                          .toList();
                      return _listView<T>(
                        list,
                        selectedType,
                      );
                    }),
              ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8),
          ),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor);
  }

  static ListView _listView<T>(
    List<T> list,
    selectedType,
  ) {
    return;
  }
}
