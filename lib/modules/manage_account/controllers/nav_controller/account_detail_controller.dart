// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/values/enum/sex.dart';
import 'package:smart_rent/core/model/values/listProvinceVietNam.dart';
import 'package:smart_rent/core/model/values/utils.dart';
import 'package:smart_rent/core/resources/storage_methobs.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class AccountDetailController extends GetxController {
  late SharedPreferences prefs;

  var photoUrl = ''.obs;
  var currentName = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;
  var sex = ''.obs;
  var dateOfBirth = ''.obs;
  var email = ''.obs;
  var isLoading = false.obs;
  Uint8List? _image;

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameTextInputController = TextEditingController();
  final TextEditingController phoneNumberTextInputController =
      TextEditingController();
  final TextEditingController addressTextInputController =
      TextEditingController();
  final TextEditingController sexTextInputController = TextEditingController();
  final TextEditingController dateOfBirthTextInputController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    //getInfo();

    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    photoUrl.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHOTOURL) ?? '';
    currentName.value = prefs.getString(KeyValue.KEY_ACCOUNT_USERNAME) ?? '';
    phoneNumber.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHONENUMBER) ?? '';
    address.value = prefs.getString(KeyValue.KEY_ACCOUNT_ADDRESS) ?? '';

    if (prefs.getBool(KeyValue.KEY_ACCOUNT_SEX)!) {
      sex.value = 'Nam';
    } else {
      sex.value = 'Nữ';
    }
    //sex.value = prefs.getBool(KeyValue.KEY_ACCOUNT_SEX) ?? '';
    dateOfBirth.value = prefs.getString(KeyValue.KEY_ACCOUNT_DATEOFBIRTH) ?? '';
    nameTextInputController.text = currentName.value;
    phoneNumberTextInputController.text = phoneNumber.value;
    addressTextInputController.text = address.value;
  }

  @override
  void dispose() {
    super.dispose();
    nameTextInputController.dispose();
    phoneNumberTextInputController.dispose();
    addressTextInputController.dispose();
    sexTextInputController.dispose();
    dateOfBirthTextInputController.dispose();
  }

  void getInfo() {}

  void showGenderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Chọn giới tính'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, EnumSex.Nam);
              },
              child: const Text('Nam'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, EnumSex.Nu);
              },
              child: const Text('Nữ'),
            ),
          ],
        );
      },
    ).then((selectedGender) {
      if (selectedGender != null) {
        selectedGender == EnumSex.Nam ? sex.value = 'Nam' : sex.value = 'Nữ';
        //sex.value = selectedGender;
        //Get.snackbar('title', 'Giới tính đã chọn: $selectedGender');
      }
    });
  }

  Future<void> changeImage(BuildContext context) async {
    showModalBottomSheet(
      context: context, // Use the context of the current Scaffold.
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  _image = await pickImage(ImageSource.camera);
                  if (_image != null) {
                    isLoading.value = true;
                    Get.back();
                    String photoUrlDevice = await StorageMethods()
                        .uploadImageToStorage(
                            KeyValue.KEY_STORAGE_ACCOUNT_IMG, _image!, false);

                    photoUrl.value = photoUrlDevice;
                    await prefs.setString(
                        KeyValue.KEY_ACCOUNT_PHOTOURL, photoUrlDevice);

                    FirebaseFirestore.instance
                        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update(
                            {KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrlDevice});

                    getInfo();
                  } else {
                    Get.back();
                    Get.snackbar('Notify', 'No photo selected');
                  }
                  isLoading.value = false;
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      color: primary40,
                      size: 24,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(
                        fontSize: 18,
                        color: primary40,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async {
                  _image = await pickImage(ImageSource.gallery);
                  if (_image != null) {
                    Get.back();
                    isLoading.value = true;
                    String photoUrlDevice = await StorageMethods()
                        .uploadImageToStorage(
                            KeyValue.KEY_STORAGE_ACCOUNT_IMG, _image!, false);

                    photoUrl.value = photoUrlDevice;
                    await prefs.setString(
                        KeyValue.KEY_ACCOUNT_PHOTOURL, photoUrlDevice);

                    FirebaseFirestore.instance
                        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update(
                            {KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrlDevice});

                    getInfo();
                  } else {
                    Get.back();
                    Get.snackbar('Notify', 'No photo selected');
                  }
                  isLoading.value = false;
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: primary40,
                      size: 24,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        fontSize: 18,
                        color: primary40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      if (is18OrOlder(selectedDate)) {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: const Text('Thông báo'),
        //       content:
        //           const Text('Ngày tháng năm sinh hợp lệ (lớn hơn 18 tuổi)'),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: const Text('OK'),
        //         ),
        //       ],
        //     );
        //   },
        // );

        String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        dateOfBirth.value = formattedDate;
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Thông báo'),
              content: const Text(
                  'Ngày tháng năm sinh không hợp lệ (nhỏ hơn 18 tuổi)'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool is18OrOlder(DateTime selectedDate) {
    final currentDate = DateTime.now();
    var age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      age--;
    }
    return age >= 18;
  }

  void showProvinceSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn tỉnh'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provinces.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(provinces[index]),
                  onTap: () {
                    address.value = provinces[index];
                    Get.back();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<String> updateInfo() async {
    formKey.currentState!.save();
    String res = 'Some error occurred';
    String currentName = nameTextInputController.text.trim();
    print(currentName);
    if (currentName == null || currentName.isEmpty || currentName.length < 6) {
      return 'Vui lòng nhập đúng định dạng họ tên';
    }
    try {
      FirebaseFirestore.instance
          .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        KeyValue.KEY_ACCOUNT_USERNAME: currentName,
        KeyValue.KEY_ACCOUNT_ADDRESS: address.value,
        KeyValue.KEY_ACCOUNT_SEX: sex.value == 'Nam' ? true : false,
        KeyValue.KEY_ACCOUNT_DATEOFBIRTH: dateOfBirth.value,
      });
      res = 'Update successfully';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  void changeSex() {}

  void changeDateOfBirth(BuildContext context) {}
}
