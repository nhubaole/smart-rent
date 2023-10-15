import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    sexTextInputController.text = sex.value;
    dateOfBirthTextInputController.text = dateOfBirth.value;
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

  void updateInfo() {}

  void changeSex() {}

  void changeDateOfBirth(BuildContext context) {}
}
