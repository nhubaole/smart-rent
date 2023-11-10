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
    getInfo();
    super.onInit();
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
                          color: primary40,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.close,
                          color: secondary40,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primary98),
                  child: InkWell(
                    onTap: () async {
                      _image = await pickImage(ImageSource.camera);
                      if (_image != null) {
                        Get.back();
                        isLoading.value = true;
                        String photoUrlDevice = await StorageMethods()
                            .uploadImageToStorage(
                                KeyValue.KEY_STORAGE_ACCOUNT_IMG,
                                _image!,
                                false);

                        _photoUrl.value = photoUrlDevice;
                        await prefs.setString(
                            KeyValue.KEY_ACCOUNT_PHOTOURL, photoUrlDevice);

                        FirebaseFirestore.instance
                            .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrlDevice
                        });

                        getInfo();
                      } else {
                        Get.back();
                        Get.snackbar('Notify', 'No photo selected');
                      }
                      isLoading.value = false;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: primary60,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Chụp ảnh',
                            style: TextStyle(
                                color: primary60,
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
                      color: primary98),
                  child: InkWell(
                    onTap: () async {
                      _image = await pickImage(ImageSource.gallery);
                      if (_image != null) {
                        String photoUrlDevice = await StorageMethods()
                            .uploadImageToStorage(
                                KeyValue.KEY_STORAGE_ACCOUNT_IMG,
                                _image!,
                                false);

                        _photoUrl.value = photoUrlDevice;
                        await prefs.setString(
                            KeyValue.KEY_ACCOUNT_PHOTOURL, photoUrlDevice);

                        FirebaseFirestore.instance
                            .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrlDevice
                        });

                        getInfo();
                      } else {
                        Get.snackbar('Notify', 'No photo selected');
                      }
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            color: primary60,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Chọn từ thư viện',
                            style: TextStyle(
                                color: primary60,
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
}
