import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  List<Map<String, String>> items = [
    {
      "image": "order",
      "label": "অর্ডার",
    },
    {
      "image": "design",
      "label": "পেইন্টেড শাড়ি",
    },
    {
      "image": "raw_sari",
      "label": "শাড়ি",
    },
    {
      "image": "cart",
      "label": "সাপ্লায়",
    },
  ];
}
