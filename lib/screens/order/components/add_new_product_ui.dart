import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_manager/models/designed_sari.dart';
import 'package:my_manager/screens/designed_sari/component/designed_raw_sari_title.dart';
import 'package:my_manager/screens/designed_sari/controllers/designed_sari_controller.dart';
import 'package:my_manager/utility/loading.dart';
import 'package:my_manager/widget/custom_picker.dart';
import 'package:my_manager/widget/input_box.dart';

class AddNewProductUi extends StatelessWidget {
  final void Function(DesignedSari) onDesignPicked;

  const AddNewProductUi({
    Key? key,
    required this.onDesignPicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<DesignedSari>? saris =
            Get.find<DesignedSariController>().designedSariList.value;
        return InputBox(
          height: 60,
          child: saris == null
              ? const Center(
                  child: Loading(),
                )
              : GestureDetector(
                  onTap: () async {
                    DesignedSari? designedSari =
                        await CustomPickerWithCustomUiController.show<
                            DesignedSari>(
                      title: "ডিজাইনড শাড়ি",
                      items: saris,
                      getId: (sari) => sari.id,
                      pickerItemBuilder: (sari) => DesignedSariTile(sari: sari),
                    );
                    if (designedSari != null) {
                      onDesignPicked(designedSari);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/bottom_bar_icons/design_1.png',
                          height: 24,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          "ডিজাইনড শাড়ি নির্বাচন করুন",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
