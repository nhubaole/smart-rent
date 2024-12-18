import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/rating_level.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/payment/payment_detail_info_model.dart';
import 'package:smart_rent/core/model/rating/rating_tenant_create_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/rating/rating_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class LandlordReturnRatingController extends GetxController {
  BillByIdModel? billByIdModel;
  PaymentDetailInfoModel? paymentDetailInfoModel;
  int? paymentId;
  UserModel? tenant;

  final commentTextEditController = TextEditingController();
  final pickerImage = ImagePicker();

  final pickedImages = Rxn<List<XFile>>([]);
  final initialRating = 5.0;
  final minRating = 0.0;
  final userRatingStar = 5.0.obs;
  final isLoadingType = LoadingType.INIT.obs;
  final questionsRatingLandlordMap = <String, RatingLevel>{
    'tenant_payment_on_time'.tr: RatingLevel.AVERAGE,
    'tenant_protects_property'.tr: RatingLevel.AVERAGE,
    'tenant_no_disturbance'.tr: RatingLevel.AVERAGE,
    'tenant_follows_rules'.tr: RatingLevel.AVERAGE,
  }.obs;
  final listImages = <String>[].obs;

  bool get validImageTotal => listImages.length < 20 && listImages.isNotEmpty;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      billByIdModel = args['bill'];
      paymentDetailInfoModel = args['payment_detail_info'];
      paymentId = args['payment_id'];
      tenant = args['tenant'];
    } else {
      Get.back();
    }
    super.onInit();
  }

  @override
  void onClose() {
    commentTextEditController.dispose();
    super.onClose();
  }

  onPickGallery() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final images = await pickerImage.pickMultiImage();
    List<String> roomImages = [];
    for (final i in images) {
      pickedImages.value?.add(i);
      pickedImages.update(
        (val) {},
      );

      final compressedImage = await Helper.compressImage(imageFile: i);
      roomImages.add(compressedImage.path);
    }

    listImages.value = [...listImages, ...roomImages];
  }

  onSend() async {
    if (listImages.isEmpty) {
      AlertSnackbar.show(
          title: 'Lưu thông tin',
          message: 'Vui lòng chụp ít nhất 1 hình ảnh',
          isError: true);
      return;
    }
    final RatingTenantCreateModel ratingTenantCreateModel =
        RatingTenantCreateModel(
      tenantId: tenant!.id,
      paymentRating:
          questionsRatingLandlordMap['tenant_payment_on_time'.tr]!.value,
      propertyCareRating:
          questionsRatingLandlordMap['tenant_protects_property'.tr]!.value,
      neighborDisturbanceRating:
          questionsRatingLandlordMap['tenant_no_disturbance'.tr]!.value,
      contractComplianceRating:
          questionsRatingLandlordMap['tenant_follows_rules'.tr]!.value,
      overallRating: userRatingStar.value.toInt(),
      comment: commentTextEditController.text.trim(),
      images: listImages,
    );
    OverlayLoading.show();
    final rq = await RatingRepoImpl().createRatingTenant(
      ratingTenantCreateModel: ratingTenantCreateModel,
    );
    OverlayLoading.hide();
    if (rq.isSuccess()) {
      Get.offNamedUntil(AppRoutes.landlordReturnRatingSuccess,
          (route) => route.settings.name == AppRoutes.root);
    }
  }

  onRemoveImage(XFile xFile, int index) {
    final images = List<XFile>.from(pickedImages.value!);
    images.removeAt(index);
    pickedImages.value = images;
  }
}
