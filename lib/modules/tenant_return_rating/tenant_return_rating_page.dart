import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/rating_level.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/tenant_return_rating/tenant_return_rating_controller.dart';

class TenantReturnRatingPage extends GetView<TenantReturnRatingController> {
  const TenantReturnRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      enabelSafeArea: true,
      // appBar: CustomAppBar(title: 'review_room'.tr),
      // body: CustomScrollView(
      //   controller: controller.scrollController,
      //   slivers: [
      //     _buildSilverAppBar(context),
      //     SliverList(
      //       delegate: SliverChildListDelegate.fixed(
      //         addRepaintBoundaries: true,
      //         addAutomaticKeepAlives: true,
      //         [
      //           Column(
      //             mainAxisSize: MainAxisSize.max,
      //             children: [
      //               TabBarView(
      //                 controller: controller.tabController,
      //                 children: [
      //                   _buildSliverListReviewRoom(),
      //                   _buildSliverListReviewLandlord(),
      //                 ],
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildSilverAppBar(context),
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: [
            _buildSliverListReviewRoom(),
            _buildSliverListReviewLandlord(),
          ],
        ),
      ),
      // bottomNavigationBar: OutlineButtonWidget(
      //   height: 50.px,
      //   margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 4.px),
      //   text: 'continue'.tr,
      //   onTap: () {},
      //   leading: const Icon(
      //     Icons.edit,
      //     color: AppColors.primary60,
      //   ),
      // ),
    );
  }

  Widget _buildSliverListReviewLandlord() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 16.px),
          _buildLanlordRating(),
          Divider(
            color: AppColors.secondary80.withOpacity(0.4),
            thickness: 0.5,
            height: 32.px,
          ),
          _buildRatingQuestions(
            questions: controller.questionsRatingLandlordMap,
            onChanged: (key, value) {
              controller.onSetQuestionRatingLandlord(key, value);
            },
          ),
          OutlineTextFiledWidget(
            textLabel: 'landlord_comment_prompt'.tr,
            textEditingController: controller.commentTextEditController,
            onValidate: (p0) {
              return null;
            },
            hintText: 'write_experience'.tr,
            minlines: 5,
          ),
          SizedBox(height: 16.px),
          OutlineButtonWidget(
            height: 50.px,
            margin: EdgeInsets.symmetric(vertical: 4.px),
            text: 'continue'.tr,
            onTap: controller.onSent,
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primary60,
            ),
          ),
          SizedBox(height: 16.px),
        ],
      ),
    );
  }

  Widget _buildSliverListReviewRoom() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 16.px),
          _buildStarRating(),
          Divider(
            color: AppColors.secondary80.withOpacity(0.4),
            thickness: 0.5,
            height: 32.px,
          ),
          _buildRatingQuestions(
            questions: controller.questionsRatingRoomMap,
            onChanged: (key, value) {
              controller.onSetQuestionRatingRoom(key, value);
            },
          ),
          OutlineTextFiledWidget(
            textLabel: 'review_comment_prompt'.tr,
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
          _buildShareImageRoom(),
          SizedBox(height: 16.px),
          OutlineButtonWidget(
            height: 50.px,
            margin: EdgeInsets.symmetric(vertical: 4.px),
            text: 'continue'.tr,
            onTap: controller.onNext,
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primary60,
            ),
          ),
          SizedBox(height: 16.px),
        ],
      ),
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
              color: AppColors.secondary40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _buildOptionImage(
          title: 'upload_image_from_library'.tr,
          onTap: () {},
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
    return DottedBorder(
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
            // padding: EdgeInsets.all(8.px),
            alignment: Alignment.center,
            height: 120.px,
            child: Column(
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

  Widget _buildLanlordRating() {
    final textStyleDefault = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary20,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'review_landlord'.tr,
            style: textStyleDefault,
          ),
        ),
        SizedBox(height: 16.px),
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
                  'Nguyễn Xuân Phương'.tr,
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

  Widget _buildStarRating() {
    final textStyleDefault = TextStyle(
      fontSize: 16.sp,
      color: AppColors.secondary20,
      fontWeight: FontWeight.bold,
    );
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'review_this_room'.tr,
            style: textStyleDefault,
          ),
        ),
        SizedBox(height: 16.px),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.px),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'excellent'.tr,
                    style: textStyleDefault.copyWith(
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

  Widget _buildSilverAppBar(BuildContext context) {
    final textStyleDefault = TextStyle(
      fontSize: 18.sp,
      color: AppColors.white,
      fontWeight: FontWeight.w700,
    );
    return Obx(
      () => SliverAppBar(
        backgroundColor: AppColors.primary60,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
          ),
        ),
        title: controller.isScroll.value
            ? const SizedBox.shrink()
            : Text(
                'review_room'.tr,
                style: textStyleDefault,
              ),
        floating: true,
        expandedHeight: 30.h,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: !controller.isScroll.value
                    ? EdgeInsets.symmetric(
                        horizontal: 16.px,
                      )
                    : EdgeInsets.only(right: 16.px),
                child: Center(
                  child: Text(
                    'CHDV Cao cấp chuyên nghiệp Nguyễn Văn Linh Quận 7',
                    style: textStyleDefault.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: controller.isScroll.value ? 1 : null,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Visibility(
                visible: !controller.isScroll.value,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '320 Nguyễn Văn Linh, Phường Bình Thuận, Quận 7, Hồ Chí Minh',
                        style: textStyleDefault.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        '23/08/2023 - 12/10/2024',
                        style: textStyleDefault.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          collapseMode: CollapseMode.parallax,
          centerTitle: !controller.isScroll.value,
          expandedTitleScale: 1.2,
          background: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: CacheImageWidget(
              overlay: AppColors.secondary20.withOpacity(0.3),
              imageUrl: ImageAssets.demo,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.px),
                bottomRight: Radius.circular(30.px),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
