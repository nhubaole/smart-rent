import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/enums/rating_level.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/auth/controller/auth_controller.dart';

class TenantReturnRatingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final initialRating = 5.0;
  final minRating = 0.0;
  final scrollController = ScrollController();
  final commentTextEditController = TextEditingController();
  final authController = Get.find<AuthController>();

  late TabController tabController;

  final isScroll = false.obs;
  final userRatingStar = 5.0.obs;
  final questionsRatingRoomMap = <String, RatingLevel>{
    'amenities_question'.tr: RatingLevel.AVERAGE,
    'location_services_question'.tr: RatingLevel.AVERAGE,
    'cleanliness_question'.tr: RatingLevel.AVERAGE,
    'price_question'.tr: RatingLevel.AVERAGE,
  }.obs;

  final questionsRatingLandlordMap = <String, RatingLevel>{
    'landlord_friendliness_question'.tr: RatingLevel.AVERAGE,
    'landlord_professionalism_question'.tr: RatingLevel.AVERAGE,
    'landlord_support_question'.tr: RatingLevel.AVERAGE,
    'landlord_transparency_question'.tr: RatingLevel.AVERAGE,
  }.obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    _initScrollController();
    super.onInit();
  }

  _initScrollController() {
    scrollController.addListener(() {
      print(scrollController.offset);
      if (scrollController.offset > 20.h) {
        isScroll.value = true;
      } else {
        isScroll.value = false;
      }
    });
  }

  @override
  void onClose() {
    commentTextEditController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  onSetQuestionRatingRoom(String key, RatingLevel value) {
    questionsRatingRoomMap[key] = value;
  }

  onSetQuestionRatingLandlord(String key, RatingLevel value) {
    questionsRatingLandlordMap[key] = value;
  }

  onNext() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    tabController.animateTo(tabController.index + 1);
  }

  onSent() {
    Get.offNamedUntil(
      AppRoutes.tenantReturnRatingSuccess,
      (route) => route.settings.name == AppRoutes.root,
    );
  }
}
