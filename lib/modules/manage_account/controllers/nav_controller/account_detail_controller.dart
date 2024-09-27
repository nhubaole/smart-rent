// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/app_colors.dart';
import '/core/model/account/Account.dart';
import '/core/model/values/enum/sex.dart';
import '/core/model/values/listProvinceVietNam.dart';
import '/core/model/values/utils.dart';
import '/core/resources/auth_methods.dart';
import '/core/resources/storage_methobs.dart';
import '/core/values/key_value.dart';
import '/core/values/app_colors.dart';

class AccountDetailController extends GetxController {
  var profileOwner = Rx<Account?>(null);

  var isLoading = false.obs;
  var isUpdate = false.obs;
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
    isLoading.value = true;
    getProfile(FirebaseAuth.instance.currentUser!.uid);
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  // Future<void> initSharedPreferences() async {
  //   prefs = await SharedPreferences.getInstance();

  //   photoUrl.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHOTOURL) ?? '';
  //   currentName.value = prefs.getString(KeyValue.KEY_ACCOUNT_USERNAME) ?? '';
  //   phoneNumber.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHONENUMBER) ?? '';
  //   address.value = prefs.getString(KeyValue.KEY_ACCOUNT_ADDRESS) ?? '';

  //   if (prefs.getBool(KeyValue.KEY_ACCOUNT_SEX)!) {
  //     sex.value = 'Nam';
  //   } else {
  //     sex.value = 'Nữ';
  //   }
  //   //sex.value = prefs.getBool(KeyValue.KEY_ACCOUNT_SEX) ?? '';

  //   dateOfBirth.value = prefs.getString(KeyValue.KEY_ACCOUNT_DATEOFBIRTH) ?? '';
  //   nameTextInputController.text = currentName.value;
  //   phoneNumberTextInputController.text = phoneNumber.value;
  //   addressTextInputController.text = address.value;
  // }

  @override
  void dispose() {
    super.dispose();
    nameTextInputController.dispose();
    phoneNumberTextInputController.dispose();
    addressTextInputController.dispose();
    sexTextInputController.dispose();
    dateOfBirthTextInputController.dispose();
  }

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
        selectedGender == EnumSex.Nam
            ? profileOwner.value = profileOwner.value!.copyWith(sex: true)
            : profileOwner.value = profileOwner.value!.copyWith(sex: false);
        //sex.value = selectedGender;
        //Get.snackbar('title', 'Giới tính đã chọn: $selectedGender');
      }
    });
  }

  Future<void> changeImage(BuildContext context) async {
    showModalBottomSheet(
      context: context, // Use the context of the current Scaffold.
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    const Text(
                      'Chọn ảnh',
                      style: TextStyle(
                          color: AppColors.primary40,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.secondary40,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary98),
                  child: InkWell(
                    onTap: () async {
                      _image = await pickImage(ImageSource.camera);
                      if (_image != null) {
                        isUpdate.value = true;
                        Get.back();
                        String photoUrlDevice = await StorageMethods()
                            .uploadImageToStorage(
                                KeyValue.KEY_STORAGE_ACCOUNT_IMG,
                                _image!,
                                false);

                        profileOwner.value = profileOwner.value!
                            .copyWith(photoUrl: photoUrlDevice);

                        FirebaseFirestore.instance
                            .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrlDevice
                        });
                      } else {
                        Get.back();
                        Get.snackbar('Notify', 'No photo selected');
                      }
                      isUpdate.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: AppColors.primary60,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Chụp ảnh',
                            style: TextStyle(
                                color: AppColors.primary60,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary98),
                  child: InkWell(
                    onTap: () async {
                      _image = await pickImage(ImageSource.gallery);
                      if (_image != null) {
                        Get.back();
                        isUpdate.value = true;
                        String photoUrlDevice = await StorageMethods()
                            .uploadImageToStorage(
                                KeyValue.KEY_STORAGE_ACCOUNT_IMG,
                                _image!,
                                false);

                        profileOwner.value = profileOwner.value!
                            .copyWith(photoUrl: photoUrlDevice);

                        FirebaseFirestore.instance
                            .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrlDevice
                        });
                      } else {
                        Get.back();
                        Get.snackbar('Notify', 'No photo selected');
                      }
                      isUpdate.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            color: AppColors.primary60,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Chọn từ thư viện',
                            style: TextStyle(
                                color: AppColors.primary60,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
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
        profileOwner.value =
            profileOwner.value!.copyWith(dateOfBirth: formattedDate);
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
                    profileOwner.value =
                        profileOwner.value!.copyWith(address: provinces[index]);
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
    if (currentName.isEmpty || currentName.length < 6) {
      return 'Vui lòng nhập đúng định dạng họ tên';
    }
    try {
      isUpdate.value = true;
      FirebaseFirestore.instance
          .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        KeyValue.KEY_ACCOUNT_USERNAME: currentName,
        KeyValue.KEY_ACCOUNT_ADDRESS: profileOwner.value!.address,
        KeyValue.KEY_ACCOUNT_SEX: profileOwner.value!.sex,
        KeyValue.KEY_ACCOUNT_DATEOFBIRTH: profileOwner.value!.dateOfBirth,
      });
      update();
      res = 'Update successfully';
      isUpdate.value = false;
    } catch (error) {
      res = error.toString();
    }
    return res;
  }

  void changeSex() {}

  void changeDateOfBirth(BuildContext context) {}
}
