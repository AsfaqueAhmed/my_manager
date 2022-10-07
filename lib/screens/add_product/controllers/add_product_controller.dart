import 'package:get/get.dart';

class AddProductController extends GetxController {
  //TODO: Implement AddProductController

  final entryType = EntryType.raw.obs;

  changeEntryType(EntryType type) {
    if (entryType.value != type) entryType.value = type;
  }
}

enum EntryType { designed, raw }
