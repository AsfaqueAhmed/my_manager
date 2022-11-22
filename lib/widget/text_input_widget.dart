import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'error_tooltip.dart';
import 'input_box.dart';

class TextInputWidget extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final Widget? prefix;
  final TextInputType? keyboardType;

  final String? error;

  final int? maxLength;
  final bool? hide;
  final bool removePrefixPadding;
  final bool useHintAsTitle;

  final int? lines;
  final Function(String)? onChange;

  final bool enable;

  final Color? color;

  final FocusNode? focusNode;

  final List<TextInputFormatter>? inputFormatters;

  final bool showHintAsTitle;

  final TextInputAction? textInputAction;
  final Function()? onComplete;

  final bool hideError;
  final double prefixWidth;

  const TextInputWidget({
    Key? key,
    required this.hint,
    this.controller,
    this.prefix,
    this.keyboardType,
    this.error,
    this.maxLength,
    this.prefixWidth = 88.0,
    this.hide,
    this.useHintAsTitle = false,
    this.lines,
    this.onChange,
    this.enable = true,
    this.color,
    this.focusNode,
    this.inputFormatters,
    this.removePrefixPadding = false,
    this.showHintAsTitle = true,
    this.textInputAction,
    this.onComplete,
    this.hideError = false,
  }) : super(key: key);

  @override
  TextInputWidgetState createState() => TextInputWidgetState();
}

class TextInputWidgetState extends State<TextInputWidget> {
  late bool hide;
  late FocusNode node;
  late TextEditingController controller;
  double state = 0;

  @override
  void initState() {
    hide = widget.hide ?? false;
    node = widget.focusNode ?? FocusNode();
    controller = widget.controller ?? TextEditingController();
    node.addListener(_listener);
    controller.addListener(_listener);
    _listener();
    super.initState();
  }

  void _listener() {
    if (node.hasFocus || controller.text.isNotEmpty) {
      if (state == 0) setState(() => state = 1);
    } else {
      if (state == 1) setState(() => state = 0);
    }
  }

  @override
  void dispose() {
    node.removeListener(_listener);
    controller.removeListener(_listener);
    if (widget.focusNode == null) node.dispose();
    if (widget.controller == null) controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InputBox(
          showBorder: true,
          fixedHeight: widget.lines == null || widget.lines == 1,
          bg: widget.color,
          hasError: widget.error != null,
          hideError: widget.hideError,
          usePadding: widget.lines == null || widget.lines == 1,
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: widget.removePrefixPadding
                      ? const EdgeInsets.all(00)
                      : EdgeInsets.only(
                          left: (widget.prefix == null ? 0 : 16), top: 2),
                  child: widget.prefix ?? const SizedBox(),
                ),
              ),
              Expanded(
                child: TextField(
                  textInputAction: widget.textInputAction,
                  focusNode: node,
                  enabled: widget.enable,
                  maxLines: widget.lines ?? 1,
                  inputFormatters: widget.inputFormatters,
                  onChanged: widget.onChange,
                  onEditingComplete: widget.onComplete,
                  obscureText: hide,
                  maxLength: widget.maxLength ??
                      (widget.keyboardType == TextInputType.phone
                          ? 14
                          : widget.lines != null
                              ? null
                              : 100),
                  buildCounter: (BuildContext c,
                      {int? currentLength, bool? isFocused, int? maxLength}) {
                    return const SizedBox();
                  },
                  controller: controller,
                  keyboardType: widget.keyboardType,
                  cursorHeight: 24,
                  showCursor: true,
                  cursorColor: Get.theme.primaryColor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        bottom:
                            widget.lines == 1 || widget.lines == null ? 10 : 0,
                        left: 16,
                        right: 16),
                    border: InputBorder.none,
                    //hintText: widget.useHintAsTitle ? "" : widget.hint,
                    //hintStyle: GoogleFonts.poppins(color: textGrey, fontSize: 16)
                  ),
                  style: Get.textTheme.bodyText1?.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              widget.hideError
                  ? const SizedBox()
                  : ErrorTooltip(error: widget.error),
              if (widget.hide == true)
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 4),
                    child: GestureDetector(
                      child: hide
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.remove_red_eye),
                      onTap: () {
                        setState(() {
                          hide = !hide;
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
        TweenAnimationBuilder(
            tween: Tween<double>(
              begin: state == 1 ? 0 : 1,
              end: state == 1 ? 1 : 0,
            ),
            duration: const Duration(milliseconds: 150),
            builder: (context, double val, chi) {
              return Positioned(
                  top: 16 - 22.0 * val,
                  left: 14.0 -
                      6 * val +
                      (widget.prefix == null
                          ? 0
                          : (widget.prefixWidth) - widget.prefixWidth * val),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(node);
                    },
                    child: Container(
                      color: Colors.white.withOpacity(1 * val),
                      padding: EdgeInsets.symmetric(horizontal: 8 * val),
                      child: widget.showHintAsTitle || val == 0
                          ? Text(
                              widget.hint,
                              style: TextStyle(
                                  color: Theme.of(context).disabledColor,
                                  height: 1,
                                  fontSize: 16 - 4 * val,
                                  textBaseline: TextBaseline.alphabetic),
                            )
                          : const SizedBox(),
                    ),
                  ));
            })
      ],
    );
  }
}
