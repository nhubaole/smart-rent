import 'package:get/get.dart';

class RootScreenController extends GetxController {
  final RxInt selectedPage = 0.obs;
  void changeScreen(int index) {
    selectedPage.value = index;
  }
}
