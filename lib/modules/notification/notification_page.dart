import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/widget/custom_app_bar.dart';
import 'package:smart_rent/core/widget/error_widget.dart';
import 'package:smart_rent/core/widget/keep_alive_wrapper.dart';
import 'package:smart_rent/core/widget/loading_widget.dart';
import 'package:smart_rent/core/widget/scaffold_widget.dart';
import 'package:smart_rent/modules/notification/notification_controller.dart';
import 'package:smart_rent/modules/notification/widgets/notification_item_widget.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: CustomAppBar(
        title: 'Thông báo',
        actions: [
          IconButton(
            onPressed: controller.onReadAll,
            icon: Icon(
              FontAwesomeIcons.checkDouble,
              color: AppColors.primary40,
              size: 24.px,
            ),
          )
        ],
      ),
      body: Obx(
        () => _buildWidgetStatus(),
      ),
    );
  }

  Widget _buildWidgetStatus() {
    switch (controller.isLoading.value) {
      case LoadingType.INIT:
      case LoadingType.LOADING:
        return LoadingWidget();
      case LoadingType.LOADED:
        return _buildListNoti();
      case LoadingType.ERROR:
        return ErrorCustomWidget(
          expandToCanPullToRefresh: true,
        );
    }
  }

  Widget _buildListNoti() {
    return controller.listNotifications.value.isEmpty
        ? _buildEmpty()
        : RefreshIndicator(
            onRefresh: () async {
              await controller.getListNoti();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16.px),
              child: Container(
                constraints: BoxConstraints(minHeight: Get.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildList(),
                    _buiildButtonLoadMore(),
                  ],
                ),
              ),
            ),
          );
  }

  Padding _buiildButtonLoadMore() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              const BorderSide(
                color: AppColors.primary40,
              ),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          child: const Text(
            'Xem thêm',
            style: TextStyle(
              color: AppColors.primary40,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary98,
      title: const Text(
        'Thông báo',
        style: TextStyle(
          color: AppColors.primary40,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _buildList() {
    return KeepAliveWrapper(
      wantKeepAlive: true,
      child: GetBuilder<NotificationController>(
        init: controller,
        builder: (controller) => ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 8.px),
          padding: EdgeInsets.symmetric(horizontal: 8.px),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.listNotifications.value.length,
          itemBuilder: (context, index) {
            final notificationItem = controller.listNotifications.value[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                alignment: Alignment.centerLeft,
                color: Colors.red,
                child: Container(
                  margin: const EdgeInsets.only(left: 50),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors.green,
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 50),
                  child: const Text(
                    'Undo',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              child: NotificationItemWidget(
                data: notificationItem,
                onTap: controller.onTapNoti,
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.startToEnd) {
                  Get.snackbar('delete', 'message');
                } else if (direction == DismissDirection.endToStart) {
                  Get.snackbar('undo', 'message');
                }
              },
            );
          },
        ),
      ),
    );
  }

  Center _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/empty.json',
            repeat: true,
            reverse: true,
            height: 300,
            width: double.infinity,
          ),
          const Text(
            'Bạn chưa có thông báo',
            style: TextStyle(
              color: AppColors.secondary20,
              fontSize: 18,
              fontWeight: FontWeight.w200,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Center _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary95,
        backgroundColor: Colors.white,
      ),
    );
  }
}
