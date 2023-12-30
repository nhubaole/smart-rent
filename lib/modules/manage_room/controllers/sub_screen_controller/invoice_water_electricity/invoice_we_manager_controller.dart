import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

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

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListTenant(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listTenant.value = await FireStoreMethods().getListTenant(
          FirebaseAuth.instance.currentUser!.uid, page.value += 10);
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listTenant.value = await FireStoreMethods()
          .getListTenant(FirebaseAuth.instance.currentUser!.uid, page.value);
      isLoading.value = false;
    }
  }
}
