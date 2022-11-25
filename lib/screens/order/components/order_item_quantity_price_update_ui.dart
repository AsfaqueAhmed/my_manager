import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/ordered_sari.dart';
import 'package:my_manager/screens/designed_sari/component/designed_raw_sari_title.dart';
import 'package:my_manager/widget/custom_button.dart';
import 'package:my_manager/widget/text_input_widget.dart';

class OrderedItemQuantityPriceUpdate extends StatelessWidget {
  final OrderedSari orderedSari;

  const OrderedItemQuantityPriceUpdate({Key? key, required this.orderedSari})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? price = 0, quantity = 0;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            width: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DesignedSariTile(
                  sari: orderedSari.designedSari,
                  showCount: false,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextInputWidget(
                    hint: "ইউনিট প্রাইজ",
                    onChange: (value) => price = int.tryParse(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: false,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextInputWidget(
                    hint: "পরিমাণ",
                    onChange: (value) => quantity = int.tryParse(value),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: false,
                      signed: false,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: CustomButton(
                    onPressed: () {
                      if (price != null &&
                          price != 0 &&
                          quantity != null &&
                          quantity != 0) {
                        Get.back(result: {
                          'price': price,
                          'quantity': quantity,
                        });
                      }
                    },
                    fullScreenButton: true,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
