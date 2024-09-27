import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '/core/model/account/Account.dart';
import '/core/resources/auth_methods.dart';

class PostReviewController extends GetxController {
  final String roomId;
  PostReviewController({
    required this.roomId,
  });
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var counter = Rx<int>(0);
  var sumRating = Rx<double>(0.0);
  var everage = Rx<double>(0.0);
  var counterFiveStars = Rx<int>(0);
  var counterFourStars = Rx<int>(0);
  var counterThreeStars = Rx<int>(0);
  var counterTwoStars = Rx<int>(0);
  var counterOneStars = Rx<int>(0);
  var isLoading = Rx<bool>(false);
  var isLoadMore = Rx<bool>(false);
  var response = Rx<Map<String, dynamic>>({});
  var listReview = Rx<List<Map<String, dynamic>>>([]);
  var profileOwner = Rx<Account?>(null);
  var page = Rx<int>(10);

  @override
  void onInit() {
    getProfile(FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }
}
