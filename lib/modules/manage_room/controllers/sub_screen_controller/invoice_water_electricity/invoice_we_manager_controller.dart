import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '/core/model/account/Account.dart';
import '/core/resources/auth_methods.dart';

class InvoiceWEManagerController extends GetxController {
  var isLoading = Rx<bool>(false);
  var isLoadMore = Rx<bool>(false);
  var listTenant = Rx<List<Map<String, dynamic>>>([]);
  var page = Rx<int>(10);
  var profileOwner = Rx<Account?>(null);
  @override
  void onInit() async {
    getProfile(FirebaseAuth.instance.currentUser!.uid);
    await getListTenant(false);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListTenant(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;

      isLoadMore.value = false;
    } else {
      isLoading.value = true;

      isLoading.value = false;
    }
  }
}
