import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  var room = Rx<Room>(Room());

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
  final FirebaseStorage storage = FirebaseStorage.instance;

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

  var titleTextController = TextEditingController();
  var descriptionTextController = TextEditingController();
  var regulationsTextController = TextEditingController();

  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');

  late ImagePicker picker;
  var pickedImages = Rxn<List<XFile>>([]);
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

  void onSelectRoomType(RoomType value) {}

  void onSelectGender(Gender value) {}

  // void updateInfoRoom() {
  //   room.value = room.value.copyWith(
  //     capacity: int.parse(capacityTextController.text),
  //     area: double.parse(areaTextController.text),
  //     price: int.parse(
  //       priceTextController.text.replaceAll('.', ''),
  //     ),
  //     deposit: int.parse(
  //       depositTextController.text.replaceAll('.', ''),
  //     ),
  //     electricityCost: int.parse(
  //       electricityCostTextController.text.replaceAll('.', ''),
  //     ),
  //     waterCost: int.parse(
  //       waterCostTextController.text.replaceAll('.', ''),
  //     ),
  //     internetCost: int.parse(
  //       internetCostTextController.text.replaceAll('.', ''),
  //     ),
  //     parkingFee: int.parse(
  //       parkingFeeTextController.text.replaceAll('.', ''),
  //     ),
  //   );
  // }

  void updateLocationRoom() {}

  Future<void> updateUtilitiesRoom() async {}

  void updateConfirmRoom() {}

  Future<void> postRoom() async {
    showDialogLoading('Đang đăng bài...');
    isLoading.value = true;
    String uid = '';
    try {
      await updateUtilitiesRoom();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      uid = prefs.getString(KeyValue.KEY_ACCOUNT_UID) ?? '';
    } finally {
      updateConfirmRoom();

      isLoading.value = false;
    }
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
            for (var i in images) {
              pickedImages.value?.add(i);
              pickedImages.update(
                (val) {},
              );
            }
            validImageTotal.value = true;
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
      },
    );
  }

  Future<List<int>> compressImage(File imageFile, int quality) async {
    img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;
    return img.encodeJpg(image, quality: quality);
  }

  Future<List<String>> uploadImages(List<XFile> images) async {
    List<String> urlImages = [];

    await Future.forEach(images, (XFile image) async {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          storage.ref().child('room_images/$fileName.jpg');

      List<int> compressedImage = await compressImage(File(image.path), 30);

      UploadTask uploadTask =
          storageReference.putData(Uint8List.fromList(compressedImage));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      urlImages.add(downloadURL);
      print('Image uploaded to Firebase Storage. Download URL: $downloadURL');
    });

    return urlImages;
  }

  Future<void> showDialogLoading(String message) async {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primary60,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  message,
                  style: const TextStyle(color: AppColors.primary60),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
