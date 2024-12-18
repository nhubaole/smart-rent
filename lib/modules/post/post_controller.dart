import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/config/app_constant.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/helper/helper.dart';
import 'package:smart_rent/core/model/location/city.dart';
import 'package:smart_rent/core/model/location/district.dart';
import 'package:smart_rent/core/model/location/ward.dart';
import 'package:smart_rent/core/model/room/room_create_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_loading.dart';
import 'package:smart_rent/modules/post/views/choose_image_bottom_sheet.dart';
import 'package:smart_rent/modules/post/views/confirm_page.dart';
import 'package:smart_rent/modules/post/views/info_page.dart';
import 'package:smart_rent/modules/post/views/location_page.dart';
import 'package:smart_rent/modules/post/views/utilities_page.dart';
import 'package:image/image.dart' as img;
import 'package:smart_rent/modules/post/widgets/alert_exit_post_page_dialog.dart';

class PostRoomController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late List<City> cities;
  late TabController tabController;

  final AppManager appManager = AppManager();
  final roomCreateModel = Rx<RoomCreateModel>(RoomCreateModel());
  final pickerImage = ImagePicker();

  final isLoadingData = LoadingType.INIT.obs;
  final isElectricityFree = false.obs;
  final isWaterFree = false.obs;
  final isInternetFree = false.obs;
  final hasParking = false.obs;
  final isParkingFree = false.obs;
  final activeStep = 0.obs;
  final upperBound = 5.obs;
  final isLoading = false.obs;
  final allowNext = false.obs;

  final selectedCity = Rx<City?>(null);
  final districts = Rx<List<District>>([]);
  final selectedDistrict = Rx<District?>(null);
  final wards = Rx<List<Ward>>([]);
  final selectedWard = Rx<Ward?>(null);
  final formKeyInfo = GlobalKey<FormState>();
  final formKeyLocation = GlobalKey<FormState>();
  final formKeyConfirm = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final capacityTextController = TextEditingController(text: "5");
  final areaTextController = TextEditingController(text: "5");
  final priceTextController = TextEditingController(text: "5");
  final depositTextController = TextEditingController(text: "5");
  final electricityCostTextController = TextEditingController(text: "5");
  final waterCostTextController = TextEditingController(text: "5");
  final internetCostTextController = TextEditingController(text: "5");
  final parkingFeeTextController = TextEditingController(text: "5");
  final streetTextController =
      TextEditingController(text: 'Street ${DateTime.now()}');
  final addressTextController =
      TextEditingController(text: 'Address ${DateTime.now()}');
  final titleTextController =
      TextEditingController(text: 'Title ${DateTime.now()}');
  final descriptionTextController =
      TextEditingController(text: 'Description  ${DateTime.now()}');
  final regulationsTextController =
      TextEditingController(text: 'Regulations ${DateTime.now()}');
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  final pickedImages = Rxn<List<XFile>>([]);
  final validImageTotal = true.obs;
  final validUtilities = true.obs;

  List<String> urlImages = [];

  final utilList = AppConstant.untilitiesPostRoom.obs;
  final stepper = Rx<List<Map<String, dynamic>>>(AppConstant.stepperPostRoom);
  final headerText = AppConstant.headerTextPostRoom;
  final icons = AppConstant.iconsPostRoom;
  final contentPage = [
    InfoPage(),
    LocationPage(),
    UtilitiesPage(),
    ConfirmPage(),
  ];

  UserModel get user => appManager.currentUser!;

  @override
  void onInit() async {
    tabController = TabController(length: stepper.value.length, vsync: this);
    roomCreateModel.value = roomCreateModel.value.copyWith(
      gender: Gender.ALL,
      roomType: RoomType.DORMITORY_HOMESTAY,
    );
    priceTextController.addListener(() => formatCurrency(priceTextController));
    depositTextController
        .addListener(() => formatCurrency(depositTextController));

    electricityCostTextController
        .addListener(() => formatCurrency(electricityCostTextController));
    waterCostTextController
        .addListener(() => formatCurrency(waterCostTextController));
    internetCostTextController
        .addListener(() => formatCurrency(internetCostTextController));
    parkingFeeTextController
        .addListener(() => formatCurrency(parkingFeeTextController));
    fetchAsset();
    super.onInit();
  }

  @override
  void onClose() {
    capacityTextController.dispose();
    areaTextController.dispose();
    priceTextController.dispose();
    depositTextController.dispose();
    electricityCostTextController.dispose();
    waterCostTextController.dispose();
    internetCostTextController.dispose();
    parkingFeeTextController.dispose();
    streetTextController.dispose();
    addressTextController.dispose();
    titleTextController.dispose();
    descriptionTextController.dispose();
    regulationsTextController.dispose();
    super.onClose();
  }

  fetchAsset() async {
    isLoadingData.value = LoadingType.LOADING;
    cities = await loadCities();
    isLoadingData.value = LoadingType.LOADED;
  }

  void formatCurrency(TextEditingController textEditingController) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '');

    if (textEditingController.text.isNotEmpty) {
      final doubleAmount = double.tryParse(
        textEditingController.text.replaceAll(RegExp(r'[^\d]'), ''),
      );

      if (doubleAmount != null) {
        final formattedValue = formatter.format(doubleAmount);
        textEditingController.value = TextEditingValue(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length - 1),
        );
      }
    }
  }

  String? fieldValidator(String value) {
    return value.isEmpty ? 'Vui lòng nhập đầy đủ thông tin' : null;
  }

  void onSelectRoomType(RoomType value) {
    roomCreateModel.value = roomCreateModel.value.copyWith(roomType: value);
  }

  void onSelectGender(Gender value) {
    roomCreateModel.value = roomCreateModel.value.copyWith(gender: value);
  }

  void updateLocationRoom() {}

  Future<void> updateUtilitiesRoom() async {}

  void updateConfirmRoom() {
    print(roomCreateModel.value);
  }

  void onSavedRoom() {
    roomCreateModel.value = roomCreateModel.value.copyWith(
      title: titleTextController.text,
      description: descriptionTextController.text,
      capacity: int.tryParse(capacityTextController.text) ?? 0,
      area: double.tryParse(areaTextController.text) ?? 0,
      totalPrice: double.tryParse(
              priceTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0.0,
      deposit: double.tryParse(
              depositTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0.0,
      electricityCost: double.tryParse(electricityCostTextController.text
              .replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      waterCost: double.tryParse(
              waterCostTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      internetCost: double.tryParse(internetCostTextController.text
              .replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      parkingFee: double.tryParse(
              parkingFeeTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      addresses: [addressTextController.text, streetTextController.text],
      status: 0,
      isParking: hasParking.value,
      isRent: false,
      utilities: getUtilities(),
    );
  }

  List<Utilities> getUtilities() {
    return utilList
        .where((e) => e.isChecked)
        .map<Utilities>((e) => e.utility)
        .toList();
  }

  Future<void> postRoom() async {
    OverlayLoading.show(title: 'Đang đăng bài...');
    _onSaveDataRoomCreate();
    log('[POSTROOM] : ${roomCreateModel.value}');
    try {
      final rq = await RoomRepoImpl().createRoom(roomCreateModel.value);
      if (rq.isSuccess()) {
        OverlayLoading.hide();
        AlertSnackbar.show(
          title: 'Thành công',
          message: 'Đăng bài thành công',
          isError: false,
        );
        Get.offNamedUntil(
          AppRoutes.detail,
          arguments: {
          'id': rq.data,
          },
          (route) => route.settings.name == AppRoutes.root,
        );
      } else {
        OverlayLoading.hide();
        AlertSnackbar.show(
          title: 'Thất bại',
          message: 'Đăng bài thất bại',
          isError: true,
        );
      }
    } catch (e) {
      OverlayLoading.hide();
      AlertSnackbar.show(
        title: 'Thất bại',
        message: 'Đăng bài thất bại',
        isError: true,
      );
    } finally {
      OverlayLoading.hide();
      isLoading.value = false;
    }
  }

  Future<List<City>> loadCities() async {
    final jsonString = await rootBundle.loadString('assets/data/cities.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => City.fromJson(json)).toList();
  }

  Future<List<District>> loadDistricts(City parent) async {
    final jsonString =
        await rootBundle.loadString('assets/data/districts.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => District.fromJson(json))
        .where((element) => element.parent_code == parent.code)
        .toList();
  }

  Future<List<Ward>> loadWards(District parent) async {
    final jsonString = await rootBundle.loadString('assets/data/wards.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => Ward.fromJson(json))
        .where((element) => element.parent_code == parent.code)
        .toList();
  }

  void onRemoveImage(XFile xFile, int index) {
    final images = List<XFile>.from(pickedImages.value!);
    images.removeAt(index);
    pickedImages.value = images;
  }

  Future<void> handleChooseImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ChooseImageBottomSheet(
          onGallarySelected: () async {
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

            roomCreateModel.value.roomImages = roomImages;

            validImageTotal.value = true;
          },
          onCameraSelected: () async {
            final image =
                await pickerImage.pickImage(source: ImageSource.camera);
            if (image != null) {
              pickedImages.value?.add(image);
              pickedImages.update(
                (val) {},
              );
              final compressedImage =
                  await Helper.compressImage(imageFile: image);
              roomCreateModel.value.roomImages?.add(compressedImage.path);
            }
            validImageTotal.value = true;
          },
          messageRequestPermission:
              "Vui lòng cho phép Smart Rent truy cập tệp hình ảnh của bạn để tải lên ảnh.",
        );
      },
    );
  }

  Future<List<int>> compressImage(File imageFile, int quality) async {
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
    return img.encodeJpg(image, quality: quality);
  }

  Future<List<String>> uploadImages(List<XFile> images) async {
    List<String> urlImages = [];

    return urlImages;
  }

  onStepTapped(int index) {
    if (index < activeStep.value) {
      activeStep.value = index;
      tabController.animateTo(activeStep.value);
      return true;
    }
    return onNextButton();
    // if (allowNext.value) {
    //   allowNextPage(index: index);
    //   return true;
    // }
    // return false;
    // activeStep.value = index;
    // tabController.animateTo(index);
    // return allowNext.value;
  }

  bool onNextButton() {
    // if (activeStep.value == 2) {
    //   if (pickedImages.value!.length >= 4 && pickedImages.value!.length <= 20) {
    //     validImageTotal.value = true;
    //   } else {
    //     validImageTotal.value = false;
    //     allowNext.value = false;
    //   }
    // } else if (!formInfoKey.currentState!.validate()) {
    //   allowNext.value = false;
    // }

    // if (allowNext.value) {
    //   if (activeStep.value == 0) {
    //     activeStep.value++;
    //     tabController.animateTo(activeStep.value);
    //   } else if (activeStep.value == 1) {
    //     updateLocationRoom();
    //   }
    // }

    // if (activeStep.value < upperBound.value - 2 && allowNext.value) {
    //   activeStep.value++;
    //   tabController.animateTo(activeStep.value);
    // }
    _onSaveDataRoomCreate();
    switch (activeStep.value) {
      case 0:
        {
          if (checkAllowPassInfoPage()) {
            allowNextPage(index: 1);
            return true;
          }
          return false;
        }
      case 1:
        {
          if (checkAllowPassLocationPage()) {
            allowNextPage(index: 2);
            return true;
          }
          return false;
        }
      case 2:
        {
          if (checkAllowPassUtilitiesPage()) {
            allowNextPage(index: 3);
            return true;
          } else {
            if (!validImageTotal.value) {
              Get.closeAllSnackbars();
              AlertSnackbar.show(
                  title: 'Thiếu thông tin',
                  message:
                      'Vui lòng chọn ít nhất ${AppConstant.minCountImages} tấm ảnh',
                  isError: true);
            }

            if (!validUtilities.value) {
              Get.closeAllSnackbars();
              AlertSnackbar.show(
                  title: 'Thiếu thông tin',
                  message: 'Vui lòng chọn ít nhất 1 tiện ích',
                  isError: true);
            }
            return false;
          }
        }
      case 3:
        return false;

      default:
        return false;
    }
  }

  allowNextPage({required int index}) {
    activeStep.value = index;
    tabController.animateTo(activeStep.value);
    log('Allow next page');
    log(roomCreateModel.value.toString());
  }

  bool checkAllowPassInfoPage() {
    if (!formKeyInfo.currentState!.validate()) {
      return false;
    }
    allowNext.value = true;
    return true;
  }

  _onSaveDataRoomCreate() {
    roomCreateModel.value = roomCreateModel.value.copyWith(
      title: titleTextController.text,
      description: descriptionTextController.text,
      capacity: int.tryParse(capacityTextController.text) ?? 0,
      area: double.tryParse(areaTextController.text) ?? 0,
      totalPrice: double.tryParse(
              priceTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0.0,
      deposit: double.tryParse(
              depositTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0.0,
      electricityCost: double.tryParse(electricityCostTextController.text
              .replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      waterCost: double.tryParse(
              waterCostTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      internetCost: double.tryParse(internetCostTextController.text
              .replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      parkingFee: double.tryParse(
              parkingFeeTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      addresses: [
        addressTextController.text,
        streetTextController.text,
        selectedWard.value?.name ?? '',
        selectedDistrict.value?.name ?? '',
        selectedCity.value?.name ?? '',
      ],
      status: 0,
      isParking: hasParking.value,
      isRent: false,
      utilities: getUtilities(),
      owner: user.id,
    );

    roomCreateModel.value = roomCreateModel.value.copyWith(
        addresses: roomCreateModel.value.addresses!
            .where((element) => element.isNotEmpty)
            .toList());
  }

  bool checkAllowPassLocationPage() {
    if (!formKeyLocation.currentState!.validate()) {
      return false;
    }
    allowNext.value = true;
    return true;
  }

  bool checkAllowPassUtilitiesPage() {
    if (pickedImages.value!.length >= AppConstant.minCountImages &&
        pickedImages.value!.length <= AppConstant.maxCountImages) {
      validImageTotal.value = true;
    } else {
      validImageTotal.value = false;
      return false;
    }
    if (!checkHasUtilities()) {
      validUtilities.value = false;
      return false;
    }
    allowNext.value = true;
    return true;
  }

  bool checkHasUtilities() {
    return utilList.any((element) => element.isChecked);
  }

  onPostButton() {
    if (formKeyConfirm.currentState!.validate()) {
      formKeyConfirm.currentState!.save();
      postRoom();
    }
  }

  Future<bool> onPopInvokedWithResult() async {
    if (roomCreateModel.value.hasData) {
      return await Get.dialog(
            AlertExitPostPageDialog(
              onConfirm: () {
                Get.back(result: true);
              },
              onCancel: () {
                Get.back(result: false);
              },
              titleConfirm: 'Thoát ngay',
              titleCancel: 'Ở lại',
            ),
          ) ??
          false;
    }
    return true;
  }
}
