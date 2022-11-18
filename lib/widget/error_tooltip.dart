import 'package:flutter/material.dart';

class ErrorTooltip extends StatelessWidget {
  final String? error;

  const ErrorTooltip({Key? key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return error == null
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 4),
            child: MyTooltip(
              message: error!,
              child: const Icon(
                Icons.error_outline,
                color: Color(0xffA31911),
              ),
            ),
          );
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  const MyTooltip({super.key, required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      margin: const EdgeInsets.only(right: 22),
      verticalOffset: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.red,
      ),
      message: message,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
