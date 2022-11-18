import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/widget/input_box.dart';

import 'custom_picker.dart';
import 'error_tooltip.dart';

class DropDownInputArea<T> extends StatefulWidget {
  final List<T> items;
  final Function(T value) onSelect;
  final T? selectedItem;
  final String Function(T) getTitle;
  final String Function(T) getId;
  final String Function(T)? getSubString;
  final String? errorMessage;
  final String title;

  final bool showSearch;

  const DropDownInputArea({
    Key? key,
    required this.onSelect,
    required this.getTitle,
    required this.getId,
    required this.items,
    this.selectedItem,
    this.errorMessage,
    required this.title,
    this.showSearch = false,
    this.getSubString,
  }) : super(key: key);

  @override
  DropDownInputAreaState<T> createState() => DropDownInputAreaState<T>();
}

class DropDownInputAreaState<Type> extends State<DropDownInputArea<Type>> {
  double state = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.selectedItem == null) {
      state = 0;
    } else {
      state = 1;
    }
    return GestureDetector(
      onTap: _selectType,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InputBox(
            hasError: widget.errorMessage != null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Text(
                        widget.selectedItem != null
                            ? widget.getTitle(widget.selectedItem as Type)
                            : "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: widget.selectedItem == null
                                ? Colors.grey
                                : Colors.black),
                      ),
                    ),
                  ),
                  ErrorTooltip(
                    error: widget.errorMessage,
                  ),
                  const Icon(Icons.arrow_drop_down_sharp)
                ],
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: state == 1 ? 0 : 1, end: state == 1 ? 1 : 0),
              duration: const Duration(milliseconds: 150),
              builder: (context, val, chi) {
                return Positioned(
                    top: 16.0 - 22 * val,
                    left: 14.0 - 6 * val,
                    child: Container(
                      color: Colors.white.withOpacity(1 * val),
                      padding: EdgeInsets.symmetric(horizontal: 8 * val),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: Colors.grey,
                            height: 1,
                            fontSize: 16 - 4 * val,
                            textBaseline: TextBaseline.alphabetic),
                      ),
                    ));
              }),
        ],
      ),
    );
  }

  void _selectType() {
    Get.focusScope?.requestFocus(FocusNode());
    CustomPickerController.show<Type>(
            title: widget.title,
            getTitle: (t) => widget.getTitle(t),
            getId: (t) => widget.getId(t),
            items: widget.items.cast<Type>(),
            selectedType: widget.selectedItem,
            getSubTitle: widget.getSubString == null
                ? null
                : (t) => widget.getSubString!(t))
        .then((value) {
      if (value != null) {
        widget.onSelect(value);
      }
    });
  }
}
