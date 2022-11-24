import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_picker.dart';
import 'error_tooltip.dart';
import 'input_box.dart';

class CustomDropDownInputArea<T> extends StatefulWidget {
  final List<T> items;
  final Function(T value) onSelect;
  final T? selectedItem;
  final Widget Function(T) pickerItemBuilder;
  final Widget Function(T) pickedItemBuilder;
  final Widget Function()? itemPlaceHolder;
  final String Function(T) getId;
  final String? errorMessage;
  final String title;

  final bool enable;

  const CustomDropDownInputArea({
    Key? key,
    required this.onSelect,
    required this.getId,
    required this.items,
    this.selectedItem,
    this.errorMessage,
    required this.title,
    this.enable = true,
    required this.pickerItemBuilder,
    required this.pickedItemBuilder,
    this.itemPlaceHolder,
  }) : super(key: key);

  @override
  CustomDropDownInputAreaState<T> createState() =>
      CustomDropDownInputAreaState<T>();
}

class CustomDropDownInputAreaState<Type>
    extends State<CustomDropDownInputArea<Type>> {
  double state = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height=92.0;
    if (widget.selectedItem == null) {
      state = 0;
    } else {
      state = 1;
    }
    return GestureDetector(
      onTap: widget.enable == true ? _selectType : null,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InputBox(
            height: height,
            hasError: widget.errorMessage != null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0) +
                  const EdgeInsets.only(bottom: 4),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (widget.selectedItem != null) {
                          return widget
                              .pickedItemBuilder(widget.selectedItem as Type);
                        } else {
                          if (widget.itemPlaceHolder != null) {
                            return Column(
                              children: [
                                widget.itemPlaceHolder!(),
                                if (widget.errorMessage != null)
                                  Text(
                                    widget.errorMessage!,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 10),
                                  )
                              ],
                            );
                          }
                          return const SizedBox();
                        }
                      },
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
                    top: height/2 - height/2 * val-4,
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
    CustomPickerWithCustomUiController.show<Type>(
            title: widget.title,
            getId: (t) => widget.getId(t),
            items: widget.items.cast<Type>(),
            selectedType: widget.selectedItem,
            pickerItemBuilder: widget.pickerItemBuilder)
        .then((value) {
      if (value != null) {
        widget.onSelect(value);
      }
    });
  }
}
