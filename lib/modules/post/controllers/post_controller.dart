import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/core/widget/alert_snackbar.dart';
import 'package:smart_rent/core/widget/overlay_dialog.dart';
import '../../../core/config/app_colors.dart';
import '/core/enums/gender.dart';
import '/core/enums/room_type.dart';
import '/core/enums/utilities.dart';
import '/core/model/location/district.dart';
import '/core/model/room/util_item.dart';
import '/core/values/app_colors.dart';
import '/modules/post/views/choose_image_bottom_sheet.dart';
import '../../../core/model/location/city.dart';
import '../../../core/model/location/ward.dart';
import '../../../core/model/room/room.dart';
import 'package:image/image.dart' as img;

import '../../../core/values/KEY_VALUE.dart';

class PostController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final room = Rx<Room>(Room());

  final isElectricityFree = false.obs;
  final isWaterFree = false.obs;
  final isInternetFree = false.obs;
  final hasParking = false.obs;
  final isParkingFree = false.obs;

  late List<City> cities;
  final selectedCity = Rx<City?>(null);
  final districts = Rx<List<District>>([]);
  final selectedDistrict = Rx<District?>(null);
  final wards = Rx<List<Ward>>([]);
  final selectedWard = Rx<Ward?>(null);

  final GlobalKey<FormState> formInfoKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final capacityTextController = TextEditingController(text: "5");
  final areaTextController = TextEditingController(text: "5");
  final priceTextController = TextEditingController(text: "5");
  final depositTextController = TextEditingController(text: "5");
  final electricityCostTextController = TextEditingController(text: "5");
  final waterCostTextController = TextEditingController(text: "5");
  final internetCostTextController = TextEditingController(text: "5");
  final parkingFeeTextController = TextEditingController(text: "5");

  final streetTextController = TextEditingController(text: "5");
  final addressTextController = TextEditingController(text: "5");

  final titleTextController = TextEditingController(text: "5");
  final descriptionTextController = TextEditingController(text: "5");
  final regulationsTextController = TextEditingController(text: "5");

  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');

  late ImagePicker picker;
  final pickedImages = Rxn<List<XFile>>([]);
  RxBool validImageTotal = true.obs;
  List<String> urlImages = [];

  RxList<UtilItem> utilList = const [
    UtilItem(utility: Utilities.WC, isChecked: false),
    UtilItem(utility: Utilities.WINDOW, isChecked: false),
    UtilItem(utility: Utilities.WIFI, isChecked: false),
    UtilItem(utility: Utilities.KITCHEN, isChecked: false),
    UtilItem(utility: Utilities.LAUNDRY, isChecked: false),
    UtilItem(utility: Utilities.FRIDGE, isChecked: false),
    UtilItem(utility: Utilities.PARKING, isChecked: false),
    UtilItem(utility: Utilities.SECURITY, isChecked: false),
    UtilItem(utility: Utilities.FLEXIBLE_HOURS, isChecked: false),
    UtilItem(utility: Utilities.PRIVATE, isChecked: false),
    UtilItem(utility: Utilities.LOFT, isChecked: false),
    UtilItem(utility: Utilities.PET, isChecked: false),
    UtilItem(utility: Utilities.BED, isChecked: false),
    UtilItem(utility: Utilities.WARDROBE, isChecked: false),
    UtilItem(utility: Utilities.AIR_CONDITIONER, isChecked: false)
  ].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();

    room.value = room.value.copyWith(
      gender: Gender.ALL.getNameGenderInt(),
      roomType: RoomType.DORMITORY_HOMESTAY.getNameRoomType(),
    );
    cities = await loadCities();
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

    picker = ImagePicker();
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
    room.value = room.value.copyWith(roomType: value.getNameRoomType());
  }

  void onSelectGender(Gender value) {
    room.value = room.value.copyWith(gender: value.getNameGenderInt());
    print(room.value.gender);
  }

  void updateLocationRoom() {}

  Future<void> updateUtilitiesRoom() async {}

  void updateConfirmRoom() {
    print(room.value);
  }

  void onSavedRoom() {
    room.value = room.value.copyWith(
      title: titleTextController.text,
      description: descriptionTextController.text,
      capacity: int.tryParse(capacityTextController.text) ?? 0,
      area: double.tryParse(areaTextController.text) ?? 0,
      totalPrice: int.tryParse(
              priceTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      deposit: int.tryParse(
              depositTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      electricityCost: double.tryParse(electricityCostTextController.text
              .replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      waterCost: double.tryParse(
              waterCostTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      internetCost: double.tryParse(internetCostTextController.text
              .replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      parkingFee: int.tryParse(
              parkingFeeTextController.text.replaceAll(RegExp(r'[^\d]'), '')) ??
          0,
      address: [addressTextController.text, streetTextController.text],
      status: 0,
      isParking: hasParking.value,
      isRent: false,
      utilities: getUtilities(),
    );
  }

  List<String> getUtilities() {
    return utilList
        .where((element) => element.isChecked)
        .map((e) => e.utility.getNameUtil())
        .toList();
  }

  Future<void> postRoom() async {
    OverlayDialog.show(message: 'Đang đăng bài...');
    isLoading.value = true;
    onSavedRoom();
    try {
      final ResponseModel<int> result =
          await RoomRepoImpl().createRoom(room.value);
      final isSuccess = result.errCode == 201;

      if (isSuccess) {
        AlertSnackbar.show(
          title: 'Thành công',
          message: 'Đăng bài thành công',
          isError: false,
        );
        Get.close(2);
      } else {
        AlertSnackbar.show(
          title: 'Thất bại',
          message: 'Đăng bài thất bại',
          isError: true,
        );
      }
    } catch (e) {
      AlertSnackbar.show(
        title: 'Thất bại',
        message: 'Đăng bài thất bại',
        isError: true,
      );
      print(e.toString());
    } finally {
      OverlayDialog.hide();
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
            final images = await picker.pickMultiImage();
            List<String> roomImages = [];
            for (final i in images) {
              pickedImages.value?.add(i);
              pickedImages.update(
                (val) {},
              );
              roomImages.add(i.path);
            }
            room.value.roomImages = roomImages;

            validImageTotal.value = true;
          },
          onCameraSelected: () async {
            final image = await picker.pickImage(source: ImageSource.camera);
            if (image != null) {
              pickedImages.value?.add(image);
              pickedImages.update(
                (val) {},
              );
              room.value.roomImages?.add(image.path);
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
}
