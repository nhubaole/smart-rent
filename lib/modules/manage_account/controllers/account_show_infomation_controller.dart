import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/values/utils.dart';
import 'package:smart_rent/core/resources/storage_methobs.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class AccountShowInformationController extends GetxController {
  late SharedPreferences prefs;

  Account? currentAccount;
  final _currentName = ''.obs;
  final _photoUrl = ''.obs;
  final _email = ''.obs;
  var isLoading = false.obs;
  Uint8List? _image;

  String get currentName => _currentName.value;
  String get photoUrl => _photoUrl.value;
  String get email => _email.value;

  @override
  onInit() {
    super.onInit();
    getInfo();
  }

  Future<void> getInfo() async {
    prefs = await SharedPreferences.getInstance();
    _currentName.value =
        prefs.getString(KeyValue.KEY_ACCOUNT_USERNAME) ?? 'default';
    _photoUrl.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHOTOURL) ?? '';
    _email.value = prefs.getString(KeyValue.KEY_ACCOUNT_EMAIL) ?? '';
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
                    Get.back();
                    isLoading.value = true;
                    String photoUrlDevice = await StorageMethods()
                        .uploadImageToStorage(
                            KeyValue.KEY_STORAGE_ACCOUNT_IMG, _image!, false);

                    _photoUrl.value = photoUrlDevice;
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
                    String photoUrlDevice = await StorageMethods()
                        .uploadImageToStorage(
                            KeyValue.KEY_STORAGE_ACCOUNT_IMG, _image!, false);

                    _photoUrl.value = photoUrlDevice;
                    await prefs.setString(
                        KeyValue.KEY_ACCOUNT_PHOTOURL, photoUrlDevice);

                    FirebaseFirestore.instance
                        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update(
                            {KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrlDevice});

                    getInfo();
                  } else {
                    Get.snackbar('Notify', 'No photo selected');
                  }
                  Get.back();
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
}
