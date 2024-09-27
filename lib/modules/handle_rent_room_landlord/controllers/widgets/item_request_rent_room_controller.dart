import 'package:get/get.dart';
import '/core/model/account/Account.dart';
import '/core/resources/auth_methods.dart';

class ItemRequestRentRoomController extends GetxController {
  final Map<String, dynamic> data;
  ItemRequestRentRoomController({required this.data});
  var profileOwner = Rx<Account?>(null);
  var isLoading = false.obs;
  @override
  void onInit() {
    getProfile(data['uidTenant']);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }
}
