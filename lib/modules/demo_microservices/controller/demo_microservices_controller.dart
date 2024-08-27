import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/modules/demo_microservices/models/room_response_model.dart';
import 'package:smart_rent/modules/demo_microservices/services/demo_services.dart';

class DemoMicroservicesController extends GetxController {
  var isLoading = Rx<bool>(false);
  late final SharedPreferences prefs;
  var listRoom = Rx<List<RoomResponseModel>>([]);
  var pageIndex = 0;
  int pageCount = 10000;
  @override
  void onInit() async {
    isLoading.value = true;
    prefs = await SharedPreferences.getInstance();
    await getListRooms();
    isLoading.value = false;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getListRooms() async {
    isLoading.value = true;
    pageIndex++;
    String? token = prefs.getString('accessToken');
    if (token != null) {
      List<RoomResponseModel>? rs = await DemoServices.instance.getListRooms(
        token: token,
        pageCount: pageCount,
        pageIndex: pageIndex,
      );
      if (rs != null) {
        listRoom.value = [...listRoom.value, ...rs];
      }
      Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
    }
  }
}
