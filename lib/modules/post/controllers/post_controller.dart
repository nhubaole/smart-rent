import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/location/district.dart';
import 'package:smart_rent/core/model/room/util_item.dart';
import 'package:smart_rent/modules/post/views/choose_image_bottom_sheet.dart';

import '../../../core/model/location/city.dart';
import '../../../core/model/location/location.dart';
import '../../../core/model/location/ward.dart';
import '../../../core/model/room/room.dart';

class PostController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var room =
      Room(roomType: RoomType.DORMITORY_HOMESTAY, gender: Gender.ALL).obs;

  var isElectricityFree = false.obs;
  var isWaterFree = false.obs;
  var isInternetFree = false.obs;
  var hasParking = false.obs;
  var isParkingFree = false.obs;

  late List<City> cities;
  var selectedCity = Rx<City?>(null);
  var districts = Rx<List<District>>([]);
  var selectedDistrict = Rx<District?>(null);
  var wards = Rx<List<Ward>>([]);
  var selectedWard = Rx<Ward?>(null);

  final GlobalKey<FormState> formInfoKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var capacityTextController = TextEditingController();
  var areaTextController = TextEditingController();
  var priceTextController = TextEditingController();
  var depositTextController = TextEditingController();
  var electricityCostTextController = TextEditingController();
  var waterCostTextController = TextEditingController();
  var internetCostTextController = TextEditingController();
  var parkingFeeTextController = TextEditingController();

  var streetTextController = TextEditingController();
  var addressTextController = TextEditingController();

  late ImagePicker picker;
  var pickedImages = Rxn<List<XFile>>([]);
  RxBool validImageTotal = true.obs;

  RxList<UtilItem> utilList = [
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

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("INIT");
    cities = await loadCities();

    picker = ImagePicker();
  }

  String? fieldValidator(String value) {
    return value.isEmpty ? 'Vui lòng nhập đầy đủ thông tin' : null;
  }

  void onSelectRoomType(RoomType value) {
    room.value = room.value.copyWith(roomType: value);
  }

  void onSelectGender(Gender value) {
    room.value = room.value.copyWith(gender: value);
  }

  void updateInfoRoom() {
    room.value = room.value.copyWith(
        capacity: int.parse(capacityTextController.text),
        area: double.parse(areaTextController.text),
        price: int.parse(priceTextController.text),
        deposit: int.parse(depositTextController.text),
        electricityCost: int.parse(electricityCostTextController.text),
        waterCost: int.parse(waterCostTextController.text),
        internetCost: int.parse(internetCostTextController.text),
        parkingFee: int.parse(parkingFeeTextController.text));
  }

  void updateLocationRoom() {
    room.value = room.value.copyWith(
        location: Location(
            city: selectedCity.value!,
            district: selectedDistrict.value!,
            ward: selectedWard.value!,
            street: streetTextController.text,
            address: addressTextController.text));
    print(room.value.toString());
  }

  Future<List<City>> loadCities() async {
    var jsonString = await rootBundle.loadString('assets/data/cities.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => City.fromJson(json)).toList();
  }

  Future<List<District>> loadDistricts(City parent) async {
    var jsonString = await rootBundle.loadString('assets/data/districts.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => District.fromJson(json))
        .where((element) => element.parent_code == parent.code)
        .toList();
  }

  Future<List<Ward>> loadWards(District parent) async {
    var jsonString = await rootBundle.loadString('assets/data/wards.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => Ward.fromJson(json))
        .where((element) => element.parent_code == parent.code)
        .toList();
  }

  Future<void> handleChooseImage(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ChooseImageBottomSheet(
            onGallarySelected: () async {
              final images = await picker.pickMultiImage();
              if (images != null) {
                for (var i in images) {
                  pickedImages.value?.add(i);
                  pickedImages.update(
                    (val) {},
                  );
                }
                validImageTotal.value = true;
              }
            },
            onCameraSelected: () async {
              final image = await picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                pickedImages.value?.add(image);
                pickedImages.update(
                  (val) {},
                );
              }
              validImageTotal.value = true;
            },
            messageRequestPermission:
                "Vui lòng cho phép Smart Rent truy cập tệp hình ảnh của bạn để tải lên ảnh.",
          );
        });
  }
}
