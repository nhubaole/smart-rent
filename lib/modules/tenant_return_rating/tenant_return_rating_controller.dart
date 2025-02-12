import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/enums/rating_level.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/rating/rating_landlord_create_model.dart';
import 'package:smart_rent/core/model/rating/rating_room_create_model.dart';
import 'package:smart_rent/core/model/return_request/return_request_by_id_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/rating/rating_repo_impl.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/modules/auth/controller/auth_controller.dart';

class TenantReturnRatingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final initialRating = 5.0;
  final minRating = 0.0;
  final scrollController = ScrollController();
  final commentTextEditController = TextEditingController();
  final authController = Get.find<AuthController>();
  final images = RxnString();
  Rx<ReturnRequestByIdModel> request = ReturnRequestByIdModel().obs;
  Rx<UserModel> landlord = UserModel().obs;

  RatingLandlordCreateModel? ratingLandlordCreateModel;
  RatingRoomCreateModel? ratingRoomCreateModel;


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
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    _initScrollController();
    final args = Get.arguments;
    request.value = args['request'];
    var user = await UserRepoIml().getUserById(id: request.value.room?.owner);
    landlord.value = user.data ?? UserModel();

    super.onInit();
  }

  _initScrollController() {
    scrollController.addListener(() {
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

  onPickImage() async {
    final rq = await Helper.pickImage();
    if (rq != null) {
      images.value = rq;
    }
  }

  onSetQuestionRatingRoom(String key, RatingLevel value) {
    questionsRatingRoomMap[key] = value;
  }

  onSetQuestionRatingLandlord(String key, RatingLevel value) {
    questionsRatingLandlordMap[key] = value;
  }

  onNext() {
    if (images.value == null || images.value!.isEmpty) {
      AlertSnackbar.show(
          title: 'Thiếu dữ liệu',
          message: 'Vui lòng chụp ảnh hoặc chọn ảnh để lưu thông tin',
          isError: true);
      return;
    }
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    tabController.animateTo(tabController.index + 1);
  }

  _saveRoomRatingModel() {
    ratingRoomCreateModel = RatingRoomCreateModel(
      roomId: request.value.room?.id ?? 0,
      amenitiesRating:
          questionsRatingRoomMap['amenities_question'.tr]!.index + 1,
      locationRating:
          questionsRatingRoomMap['location_services_question'.tr]!.index + 1,
      cleanlinessRating:
          questionsRatingRoomMap['cleanliness_question'.tr]!.index + 1,
      priceRating: questionsRatingRoomMap['price_question'.tr]!.index + 1,
      overralRating: userRatingStar.value.toInt(),
      comments: commentTextEditController.text,
      images: [images.value!],
    );
  }

  _saveLandlordRatingModel() {
    ratingLandlordCreateModel = RatingLandlordCreateModel(
      landlordId: (request.value.room?.owner as UserModel).id ?? 1,
      friendlinessRating:
          questionsRatingLandlordMap['landlord_friendliness_question'.tr]!
                  .index +
              1,
      professionalismRating:
          questionsRatingLandlordMap['landlord_professionalism_question'.tr]!
                  .index +
              1,
      supportRating:
          questionsRatingLandlordMap['landlord_support_question'.tr]!.index + 1,
      transparencyRating:
          questionsRatingLandlordMap['landlord_transparency_question'.tr]!
                  .index +
              1,
      overallRating: userRatingStar.value.toInt(),
      comments: commentTextEditController.text.trim(),
    );
  }

  onSent() async {
    if (images.value == null || images.value!.isEmpty) {
      AlertSnackbar.show(
          title: 'Thiếu dữ liệu',
          message: 'Vui lòng chụp ảnh hoặc chọn ảnh để lưu thông tin',
          isError: true);
      return;
    }
    _saveRoomRatingModel();
    _saveLandlordRatingModel();
    OverlayLoading.show();
    await sendRating();
    OverlayLoading.hide();
    Get.offNamedUntil(
      AppRoutes.tenantReturnRatingSuccess,
      (route) => route.settings.name == AppRoutes.root,
    );
  }

  Future<bool> sendRating() async {
    try {
      if (ratingRoomCreateModel != null) {
        // await ratingService.createRoomRating(ratingRoomCreateModel!);
        await RatingRepoImpl()
            .createRatingRoom(ratingRoomCreateModel: ratingRoomCreateModel!);
      }
      if (ratingLandlordCreateModel != null) {
        // await ratingService.createLandlordRating(ratingLandlordCreateModel!);
        await RatingRepoImpl().createRatingLandlord(
            ratingLandlordCreateModel: ratingLandlordCreateModel!);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
