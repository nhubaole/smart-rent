import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/model/bank_model.dart';
import 'package:smart_rent/core/model/user/user_bank_info_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/model/user/user_update_bank_info_model.dart';
import 'package:smart_rent/core/model/user/user_update_info_model.dart';
import 'package:smart_rent/core/repositories/payment/payment_repo_impl.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/modules/user_profile/widgets/list_bank_bottom_sheet.dart';

class UserProfileController extends GetxController {
  List<BankModel>? banks;
  final AppManager appManager = AppManager();

  UserModel get user => appManager.currentUser!;
  UserBankInfoModel get bankInfo => user.bankInfo!;
  String get version => appManager.version;
  String get buildNumber => appManager.buildNumber;

  late final TextEditingController fullNameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController genderController;
  late final TextEditingController dobController;
  late final TextEditingController numberCreditCardController;
  late final TextEditingController nameCreditCardController;
  late final TextEditingController bandNameController;

  final formKey = GlobalKey<FormState>();

  final selectedBank = Rxn<BankModel>();

  bool get isLandlord => user.role == 1;

  @override
  void onInit() {
    _initController();
    _fetchListBank();
    _fetchUserBankInfo();
    super.onInit();
  }

  @override
  void onClose() {
    _disposeController();
    super.onClose();
  }

  _initController() {
    fullNameController = TextEditingController(text: user.fullName);
    phoneController = TextEditingController(text: user.phoneNumber);
    addressController = TextEditingController(text: user.address);
    genderController = TextEditingController(text: 'Name');
    dobController = TextEditingController(text: user.dob?.ddMMyyyy);
    numberCreditCardController = TextEditingController(text: '');
    nameCreditCardController = TextEditingController(text: '');
    bandNameController = TextEditingController(text: 'Chọn ngân hàng');
  }

  _disposeController() {
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    genderController.dispose();
    dobController.dispose();
    numberCreditCardController.dispose();
    nameCreditCardController.dispose();
    bandNameController.dispose();
  }

  onTapChoseFromDate(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final dobAt = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (dobAt != null) {
      dobController.text = dobAt.ddMMyyyy;
    }
  }

  _fetchUserBankInfo() async {
    final rq = await UserRepoIml().getBankInfo();
    if (rq.isSuccess()) {
      final bankInfo = rq.data;
      UserModel newUser = user.copyWith(bankInfo: bankInfo);
      appManager.setSession(newUser: newUser);
      selectedBank.value = BankModel(
        id: bankInfo?.bankId,
        bankName: bankInfo?.bankName,
      );
      numberCreditCardController.text = bankInfo?.accountNumber ?? '';
      nameCreditCardController.text = bankInfo?.accountName ?? '';
    }
  }

  _fetchListBank() async {
    final rq = await PaymentRepoImpl().getAllBanks();
    if (rq.isSuccess()) {
      banks = rq.data;
    } else {
      AlertSnackbar.show(
          title: 'Lỗi lấy danh sách ngân hàng',
          message: 'Danh sách ngân hàng không khả dụng, thử lại sau',
          isError: true,
          onRetry: () {
            _fetchListBank();
          });
    }
  }

  onChoseBank() {
    if (banks == null || banks!.isEmpty) {
      AlertSnackbar.show(
        title: 'Lỗi lấy danh sách ngân hàng',
        message: 'Danh sách ngân hàng không khả dụng, thử lại sau',
        isError: true,
        duration: Duration(seconds: 5),
        onRetry: () {
          _fetchListBank();
        },
      );
      return;
    }
    Get.bottomSheet(
      ListBankBottomSheet(
        onSelected: (bank) {
          FocusManager.instance.primaryFocus?.unfocus();
          bandNameController.text = bank.bankName!;
          selectedBank.value = bank;
        },
        banks: banks!,
      ),
    );
  }

  onUpdateUserProfile() async {
    if (!formKey.currentState!.validate() || selectedBank.value == null) {
      return;
    }
    formKey.currentState!.save();
    await onUpdateUserInfo();
    await onUpdateBankInfp();
  }

  Future<void> onUpdateBankInfp() async {
    final updateBankInfoModel = UserUpdateBankInfoModel(
      bankId: selectedBank.value?.id,
      accountNumber: numberCreditCardController.text.trim(),
      accountName: nameCreditCardController.text.trim(),
      currency: 'VND',
    );

    OverlayLoading.show(title: 'Đang cập nhật thông tin');
    final rqUser = await UserRepoIml()
        .updateBankInfo(userUpdateBankInfoModel: updateBankInfoModel);
    OverlayLoading.hide();
    if (rqUser.isSuccess()) {
      AlertSnackbar.show(
        title: 'Cập nhật thông tin cá nhân thành công',
        message: 'Thông tin của bạn đã được cập nhật thành công',
      );
    } else {
      AlertSnackbar.show(
        title: 'Lỗi cập nhật thông tin ngân hàng',
        message: 'Cập nhật thông tin không thành công, thử lại sau',
        isError: true,
      );
    }
  }

  Future<void> onUpdateUserInfo() async {
    final updateInfoModel = UserUpdateInfoModel(
      fullName: fullNameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      id: user.id!,
      role: user.role!,
    );

    OverlayLoading.show(title: 'Đang cập nhật thông tin');
    final rqUser =
        await UserRepoIml().updateInfo(userUpdateInfoModel: updateInfoModel);
    OverlayLoading.hide();
    if (rqUser.isSuccess()) {
      final currentUser = await UserRepoIml().getUserById(id: user.id!);
      if (currentUser.isSuccess()) {
        appManager.setSession(newUser: currentUser.data!);
        AlertSnackbar.show(
          title: 'Cập nhật thông tin thanh toán thành công',
          message: 'Thông tin của bạn đã được cập nhật thành công',
        );
      }
    } else {
      AlertSnackbar.show(
        title: 'Lỗi cập nhật thông tin',
        message: 'Cập nhật thông tin không thành công, thử lại sau',
        isError: true,
      );
    }
  }

  onUpgradeToLandlord() async {
    final updateInfoModel = UserUpdateInfoModel(
      fullName: fullNameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      id: user.id!,
      role: 1,
    );

    OverlayLoading.show(title: 'Đang cập nhật thông tin');
    final rqUser =
        await UserRepoIml().updateInfo(userUpdateInfoModel: updateInfoModel);
    OverlayLoading.hide();
    if (rqUser.isSuccess()) {
      final currentUser = await UserRepoIml().getUserById(id: user.id!);
      if (currentUser.isSuccess()) {
        appManager.setSession(newUser: currentUser.data!);
        AlertSnackbar.show(
          title: 'Cập nhật thông tin thanh toán thành công',
          message: 'Thông tin của bạn đã được cập nhật thành công',
        );
      }
    } else {
      AlertSnackbar.show(
        title: 'Lỗi cập nhật thông tin',
        message: 'Cập nhật thông tin không thành công, thử lại sau',
        isError: true,
      );
    }
  }

  onLogout() {
    AppManager.instance.forceLogOut();
  }
}
