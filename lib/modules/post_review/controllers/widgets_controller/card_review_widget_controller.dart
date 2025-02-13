import 'package:get/get.dart';
import '/core/model/account/Account.dart';
import '/core/resources/auth_methods.dart';

class CardReviewWidgetController extends GetxController {
  final Map<String, dynamic> review;
  CardReviewWidgetController({required this.review});
  var isLoading = Rx<bool>(false);
  var isLoadMore = Rx<bool>(false);
  var profileOwner = Rx<Account?>(null);

  @override
  void onInit() {
    loadDetails();
    getProfile(review['userId']);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> loadDetails() async {}
}
