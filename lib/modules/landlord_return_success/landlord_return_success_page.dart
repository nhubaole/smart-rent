import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/landlord_return_success/landlord_return_success_controller.dart';

class LandlordReturnSuccessPage
    extends GetView<LandlordReturnSuccessController> {
  const LandlordReturnSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Stack(
        children: [
          _buildBackground(),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCheckIcon(),
                SizedBox(height: 16.px),
                _buildSentSuccess(),
                SizedBox(height: 16.px),
                _buildSentSuccessDes(),
                SizedBox(height: 32.px),
                _buildSuggesstNavManageInvoice(),
                SizedBox(height: 64.px),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.px),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlineButtonWidget(
                          onTap: () {
                            Get.until(
                              (route) => route.settings.name == AppRoutes.root,
                            );
                          },
                          text: 'Để sau',
                        ),
                      ),
                      if (controller.allowReview == true)
                        SizedBox(width: 16.px),
                      if (controller.allowReview == true)
                        Expanded(
                          flex: 3,
                          child: SolidButtonWidget(
                            text: 'Đánh giá'.tr,
                            onTap: controller.onNavRating,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSuggesstNavManageInvoice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.px),
      child: Text.rich(
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(text: 'Hãy'.tr),
            const TextSpan(text: ' '),
            TextSpan(
              text: 'đánh giá người thuê'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' '),
            TextSpan(
                text:
                    'để giúp các chủ nhà khác có thêm thông tin và nâng cao chất lượng cộng đồng thuê trọ.'
                        .tr),
          ],
        ),
      ),
    );
  }

  Widget _buildSentSuccessDes() {
    final defaultTextStyle = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: AppColors.black,
    );
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.px),
      child: Column(
        children: [
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(
              text:
                  'Chúc mừng bạn! Quá trình trả phòng trọ của bạn đã hoàn tất thành công.'
                      .tr,
            ),
          ),
          SizedBox(height: 16.px),
          Text.rich(
            style: defaultTextStyle,
            textAlign: TextAlign.center,
            TextSpan(
              text:
                  'Tiền hoàn cọc sẽ được chuyển đến bạn trong vòng 07 ngày làm việc.'
                      .tr,
            ),
          ),
        ],
      ),
    );
  }

  Text _buildSentSuccess() {
    return Text.rich(
      style: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
      textAlign: TextAlign.center,
      TextSpan(text: 'Trả phòng thành công'.tr),
    );
  }

  Container _buildCheckIcon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.green20,
          width: 1.px,
        ),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(12.px),
        child: CircleAvatar(
          backgroundColor: AppColors.green20,
          radius: 48.px,
          child: Icon(
            Icons.check_rounded,
            color: AppColors.white,
            size: 48.px,
          ),
        ),
      ),
    );
  }

  Container _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFCAF0F8),
            Color(0xffFFFFFF),
          ],
        ),
      ),
    );
  }
}
