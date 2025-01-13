import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/rating_level.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/core/widget/view_image_dialog.dart';
import 'package:smart_rent/modules/landlord_return_rating/landlord_return_rating_controller.dart';
import 'package:smart_rent/modules/post/widgets/media_item_select.dart';

class LandlordReturnRatingPage extends GetView<LandlordReturnRatingController> {
  const LandlordReturnRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(title: 'Đánh giá khách thuê'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16.px),
            _buildTenantRating(),
            SizedBox(height: 32.px),
            _buildRatingQuestions(
              questions: controller.questionsRatingLandlordMap,
              onChanged: (key, value) {
                FocusManager.instance.primaryFocus?.unfocus();
                controller.questionsRatingLandlordMap[key] = value;
              },
            ),
            SizedBox(height: 32.px),
            _buildComment(),
            _buildShareImageRoom(),
            SizedBox(height: 32.px),
            SolidButtonWidget(
              height: 50.px,
              margin: EdgeInsets.symmetric(vertical: 4.px),
              text: 'Gửi'.tr,
              onTap: controller.onSend,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OutlineTextFiledWidget(
          textLabelStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary20,
            fontWeight: FontWeight.bold,
          ),
          textLabel: 'Nhận xét về khách thuê'.tr,
          textEditingController: controller.commentTextEditController,
          onValidate: (p0) {
            return null;
          },
          hintText: 'write_experience'.tr,
          minlines: 5,
        ),
        Divider(
          color: AppColors.secondary80.withOpacity(0.4),
          thickness: 0.5,
          height: 32.px,
        ),
      ],
    );
  }

  Column _buildShareImageRoom() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'share_images'.tr,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.px),
        _buildOptionImage(
          title: 'upload_image_from_library'.tr,
          onTap: controller.onPickGallery,
          icon: ImageAssets.icAddGallery,
        ),
      ],
    );
  }

  Widget _buildOptionImage({
    required String title,
    String? icon,
    required Function() onTap,
  }) {
    return Obx(
      () => DottedBorder(
        color: AppColors.secondary60,
        // padding: EdgeInsets.all(8.px),
        borderPadding: EdgeInsets.all(2.px),
        borderType: BorderType.RRect,
        radius: Radius.circular(10.px),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            splashColor: AppColors.primary80.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.px),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(8.px),
              alignment: Alignment.center,
              child: controller.listImages.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        icon != null
                            ? Image.asset(
                                icon,
                                width: 40.px,
                                height: 40.px,
                              )
                            : Icon(
                                Icons.add_a_photo_outlined,
                                color: AppColors.primary60,
                                size: 40.px,
                              ),
                        SizedBox(height: 8.px),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primary60,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 20.0,
                          ),
                          itemCount: controller.pickedImages.value?.length,
                          itemBuilder: (context, index) {
                            final XFile xFile =
                                controller.pickedImages.value!.elementAt(index);
                            return MediaItemSelect(
                                index: index,
                                xFile: xFile,
                                onRemove: controller.onRemoveImage,
                                onReview: (XFile xFile) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  ViewImageDialog.show(
                                    url: xFile.path,
                                    isLocal: true,
                                    fit: BoxFit.contain,
                                  );
                                });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Đăng thêm hình ảnh',
                          style: TextStyle(
                              color: AppColors.primary40,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                            controller.validImageTotal
                                ? '(Tối thiểu 4 ảnh, tối đa 20 ảnh)'
                                : 'Vui lòng chọn tối thiểu 4 ảnh, tối đa 20 ảnh',
                            style: TextStyle(
                              color: controller.validImageTotal
                                  ? AppColors.secondary40
                                  : AppColors.red50,
                              fontSize: 12,
                            ))
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildRatingQuestions({
    required Map<String, RatingLevel> questions,
    required Function(String, RatingLevel) onChanged,
  }) {
    return Column(
      children: questions.keys.map(
        (e) {
          final title = e;
          return Column(
            children: [
              Obx(
                () => _buildReviewField(
                  title: title,
                  onChanged: (value) {
                    onChanged(e, value);
                  },
                  selectedValue: questions[e]!,
                ),
              ),
              Divider(
                color: AppColors.secondary80.withOpacity(0.4),
                thickness: 0.5,
                height: 32.px,
              ),
            ],
          );
        },
      ).toList(),
    );
  }

  Widget _buildReviewField({
    required String title,
    required Function(RatingLevel) onChanged,
    required RatingLevel selectedValue,
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.secondary20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.px),
        _buildGroupRatingButton(onChanged, selectedValue: selectedValue),
      ],
    );
  }

  _buildGroupRatingButton(Function(RatingLevel) onChanged,
      {required RatingLevel selectedValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: RatingLevel.values
          .map<Widget>(
            (e) => _buildRatingButton(
              isSelected: e == selectedValue,
              title: e.name.tr,
              icon: e.icon,
              onPressed: () {
                onChanged(e);
              },
            ),
          )
          .toList(),
    );
  }

  _buildRatingButton({
    required String title,
    required String icon,
    required Function() onPressed,
    bool isSelected = false,
  }) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.px),
          ),
          side: const BorderSide(color: AppColors.transparent, width: 1),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8.px),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary80.withOpacity(0.5)
                    : AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                icon,
                width: 24.px,
                height: 24.px,
              ),
            ),
            SizedBox(height: 8.px),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondary20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenantRating() {
    final textStyleDefault = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary20,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.px),
              ClipOval(
                child: CacheImageWidget(
                  imageUrl: ImageAssets.demo,
                  width: 14.h,
                  height: 14.h,
                ),
              ),
              SizedBox(height: 16.px),
              Align(
                alignment: Alignment.center,
                child: Text(
                  controller.tenant?.fullName ?? '',
                  style: textStyleDefault.copyWith(fontSize: 16.sp),
                ),
              ),
              SizedBox(height: 16.px),
              RatingBar.builder(
                initialRating: controller.initialRating,
                minRating: controller.minRating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 50.px,
                unratedColor: AppColors.rating.withAlpha(50),
                direction: Axis.horizontal,
                onRatingUpdate: (double value) {
                  controller.userRatingStar.value = value;
                },
              ),
              SizedBox(height: 8.px),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'terrible'.tr,
                    style: textStyleDefault.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'excellent'.tr,
                    style: textStyleDefault.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
