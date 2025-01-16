import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/helper/help_regex.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_create_model.dart';
import 'package:smart_rent/core/repositories/rental_request/rental_request_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';

class TenantSentRentRequestController extends GetxController {
  late int roomID;
  late final TextEditingController suggestPriceController;
  late final TextEditingController peopleWillJoinController;
  late final TextEditingController specialSuggestController;
  late final TextEditingController dateStartJoinController;
  late final TextEditingController dateLeaveController;

  final canJoinNow = false.obs;
  final isLeaveDay = true.obs;
  final isCheckboxSubmitStatement = false.obs;
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    _initController();
    _initData();
    super.onInit();
  }

  @override
  void onClose() {
    _disposeController();
    super.onClose();
  }

  _initData() {
    final args = Get.arguments;
    if (args != null) {
      roomID = args['room_id'];
    }
  }

  _initController() {
    suggestPriceController = TextEditingController();
    peopleWillJoinController = TextEditingController();
    specialSuggestController = TextEditingController();
    dateStartJoinController =
        TextEditingController(text: DateTime.now().ddMMyyyy);
    dateLeaveController = TextEditingController();
    // Format currency
    suggestPriceController
        .addListener(() => HelpRegex.formatCurrency(suggestPriceController));
  }

  _disposeController() {
    suggestPriceController.dispose();
    peopleWillJoinController.dispose();
    specialSuggestController.dispose();
    dateStartJoinController.dispose();
    dateLeaveController.dispose();
  }

  onChangeJoinNow(bool value) {
    canJoinNow.value = value;
    if (!canJoinNow.value) {
      dateStartJoinController.text = DateTime.now().ddMMyyyy;
    }
  }

  // onChangeLeave(bool value) {
  //   isLeaveDay.value = value;
  //   if (!isLeaveDay.value) {
  //     dateLeaveController.text = 'Không có';
  //   }
  // }

  onTapChoseStartJoinDate(BuildContext context) async {
    if (canJoinNow.value) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final startJoinAt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (startJoinAt != null) {
      dateStartJoinController.text = startJoinAt.ddMMyyyy;
    }
  }

  onChangeSwitchLeaveDate() {
    isLeaveDay.value = !isLeaveDay.value;
    if (isLeaveDay.value) {
      dateLeaveController.text = 'Dài hạn';
    } else {
      onTapChoseLeaveDate(Get.context!);
    }
  }

  onTapChoseLeaveDate(BuildContext context) async {
    if (isLeaveDay.value) return;
    FocusManager.instance.primaryFocus?.unfocus();
    final leaveAt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (leaveAt != null) {
      dateLeaveController.text = leaveAt.ddMMyyyy;
    }
  }

  RentalRequestCreateModel? _saveData() {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    formKey.currentState!.save();
    return RentalRequestCreateModel(
      roomID: roomID,
      suggestedPrice: double.tryParse(
              suggestPriceController.text.trim().replaceAll('.', '')) ??
          0,
      numOfPerson: int.tryParse(peopleWillJoinController.text) ?? 0,
      additionRequest: specialSuggestController.text.isNotEmpty
          ? specialSuggestController.text
          : ' ',
      beginDate:
          DateTime.tryParse(dateStartJoinController.text) ?? DateTime.now(),
      endDate: DateTime.tryParse(dateLeaveController.text) ??
          DateTime.now().add(Duration(days: 365 * 5)),
    );
  }

  onSubmit() async {
    // Get.offNamedUntil(
    //   AppRoutes.tenantRentRequestSuccess,
    //   (route) => route.settings.name == AppRoutes.root,
    // );
    if (isCheckboxSubmitStatement.value == false) {
      AlertSnackbar.show(
        title: 'Thiếu hành động',
        message: 'Vui lòng đồng ý với điều khoản và điều kiện của chúng tôi',
        isError: true,
      );
      return;
    }
    final data = _saveData();
    print(data?.toMap());
    if (data == null) return;
    OverlayLoading.show(title: 'Đang gửi yêu cầu thuê phòng');
    final rq = await RentalRequestRepoImpl().createRentalRequest(data);
    if (rq.isSuccess()) {
      Get.offNamedUntil(
        AppRoutes.tenantRentRequestSuccess,
        (route) => route.settings.name == AppRoutes.root,
      );
    } else {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Lỗi',
        message: rq.message ?? 'Có lỗi xảy ra',
        isError: true,
      );
    }
  }
}
