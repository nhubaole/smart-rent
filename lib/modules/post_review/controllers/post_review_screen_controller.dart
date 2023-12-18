import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

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
    getListReviews(false);
    getProfile(FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListReviews(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listReview.value.clear();
      response.value =
          await FireStoreMethods().getListReviews(roomId, page.value += 10);
      listReview.value = response.value['list'];
      counter.value = listReview.value.length;
      sumRating.value = response.value['sumRating'];
      everage.value = sumRating.value / counter.value * 1.0;
      counterFiveStars.value = response.value['counterFiveStars'];
      counterFourStars.value = response.value['counterFourStars'];
      counterThreeStars.value = response.value['counterThreeStars'];
      counterTwoStars.value = response.value['counterTwoStars'];
      counterOneStars.value = response.value['counterOneStars'];
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listReview.value.clear();
      response.value = await FireStoreMethods().getListReviews(roomId, 10);
      listReview.value = response.value['list'];
      counter.value = listReview.value.length;
      sumRating.value = response.value['sumRating'];
      everage.value = sumRating.value / counter.value * 1.0;
      counterFiveStars.value = response.value['counterFiveStars'];
      counterFourStars.value = response.value['counterFourStars'];
      counterThreeStars.value = response.value['counterThreeStars'];
      counterTwoStars.value = response.value['counterTwoStars'];
      counterOneStars.value = response.value['counterOneStars'];
      isLoading.value = false;
    }
  }
}
