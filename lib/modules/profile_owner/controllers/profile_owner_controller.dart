import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';

class ProfileOwnerController extends GetxController {
  var profileOwner = Rx<Account?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails();
    isLoading.value = false;
  }

  Future<void> getListRoom() async {}
}
