import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/outline_button_widget.dart';
import 'package:smart_rent/core/widget/post_room_stepper.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/core/widget/solid_button_widget.dart';
import 'package:smart_rent/modules/post/post_controller.dart';

class PostRoomPage extends GetView<PostRoomController> {
  const PostRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldExit = await controller.onPopInvokedWithResult();
        if (context.mounted && shouldExit) {
          Get.back();
        }
      },
      child: SafeArea(
        top: false,
        child: ScaffoldWidget(
          appBar: _buildAppbar(context),
          body: Obx(() => _buildWidgetByStatus()),
          bottomNavigationBar: Obx(() => _buildNavigationButton()),
        ),
      ),
    );
  }

  Widget _buildWidgetByStatus() {
    switch (controller.isLoadingData.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return const LoadingWidget();
      case LoadingType.LOADED:
        return _buildBody();
      case LoadingType.ERROR:
        return const ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildNavigationButton() {
    if (controller.isLoading.value == false &&
        controller.isLoadingData.value == LoadingType.LOADED) {
      return _buildNextButton();
    }
    return const SizedBox.shrink();
  }

  Widget _buildBody() {
    return Column(
      children: [
        PostRoomStepper<Map<String, dynamic>>(
          tabs: controller.stepper.value,
          initStep: controller.activeStep.value,
          onStepTapped: (p0) async {
            final result = await controller.onStepTapped(p0);
            return result;
          },
          selectedColor: AppColors.primary40,
          unselectedColor: AppColors.secondary60,
        ),
        SizedBox(height: 16.px),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            children: controller.contentPage,
          ),
        )
      ],
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      toolbarHeight: 64.0,
      title: const Text(
        'Đăng phòng',
        style: TextStyle(
            color: AppColors.primary40,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primary40),
        onPressed: () async {
          final canPop = await controller.onPopInvokedWithResult();
          if (canPop) {
            Get.back();
          }
        },
      ),
      backgroundColor: primary80,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary95,
              Colors.white,
            ],
          ),
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: true,
      titleSpacing: 0,
      iconTheme: const IconThemeData(color: AppColors.primary40),
    );
  }

  /// Returns the next button.
  Widget _buildNextButton() {
    return SizedBox(
      height: 50,
      child: controller.activeStep.value == 3
          ? _buildButtonPost()
          : _buildButtonNext(),
    );
  }

  Widget _buildButtonNext() {
    return OutlineButtonWidget(
      margin: EdgeInsets.only(left: 20.px, right: 20.px, bottom: 2.px),
      padding: EdgeInsets.zero,
      onTap: controller.onNextButton,
      text: 'Tiếp theo',
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 20,
        color: AppColors.primary60,
      ),
    );
  }

  Widget _buildButtonPost() {
    return SolidButtonWidget(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(left: 20.px, right: 20.px, bottom: 2.px),
      text: 'Đăng bài',
      onTap: controller.postRoom,
      leading: const Icon(
        Icons.add_box_rounded,
        size: 20,
        color: Colors.white,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      decoration: BoxDecoration(
          color: AppColors.primary95, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          controller.headerText[controller.activeStep.value],
          style: const TextStyle(
            color: AppColors.primary60,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
