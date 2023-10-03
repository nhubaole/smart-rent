import 'package:get/get.dart';

class HomePopularController extends GetxController {
  RxList<String> dataList = <String>[].obs;
  var isLoading = true.obs;

  Future<void> fetchDataAndConvertToList() async {
    await Future.delayed(const Duration(seconds: 2));
    List<String> fetchedData = [
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 1",
      "Item 2",
      "Item 3",
      "Item 1",
      "Item 2",
      "Item 3"
    ];
    dataList.assignAll(fetchedData);
    isLoading.value = false;
  }
}
