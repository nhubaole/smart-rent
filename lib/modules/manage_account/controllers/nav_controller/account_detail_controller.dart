import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/values/utils.dart';
import 'package:smart_rent/core/resources/storage_methobs.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class AccountDetailController extends GetxController {
  final box = GetStorage();
  Account? currentAccount;
  final _currentName = ''.obs;
  final _photoUrl = ''.obs;
  final _email = ''.obs;
  Uint8List? _image;

  String get currentName => _currentName.value;
  String get photoUrl => _photoUrl.value;
  String get email => _email.value;

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
    nameTextInputController.text = 'Lê Bảo Như';
    phoneNumberTextInputController.text = '0987654321';
    addressTextInputController.text = 'Thủ Đức, TPHCM';
    sexTextInputController.text = 'Nữ';
    dateOfBirthTextInputController.text = '2003';
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

  void getInfo() {
    _currentName.value = box.read(KeyValue.KEY_ACCOUNT_USERNAME);
    _photoUrl.value = box.read(KeyValue.KEY_ACCOUNT_PHOTOURL);
    _email.value = box.read(KeyValue.KEY_ACCOUNT_EMAIL);
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
                    String photoUrl = await StorageMethods()
                        .uploadImageToStorage(
                            KeyValue.KEY_STORAGE_ACCOUNT_IMG, _image!, false);
                    box.write(KeyValue.KEY_ACCOUNT_PHOTOURL, photoUrl);
                    FirebaseFirestore.instance
                        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                        .doc(box.read(KeyValue.KEY_ACCOUNT_UID))
                        .update({KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrl});
                    getInfo();
                  } else {
                    Get.snackbar('Notify', 'No photo selected');
                  }
                  Get.back();
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
                    String photoUrl = await StorageMethods()
                        .uploadImageToStorage(
                            KeyValue.KEY_STORAGE_ACCOUNT_IMG, _image!, false);
                    print(photoUrl);

                    box.write(KeyValue.KEY_ACCOUNT_PHOTOURL, photoUrl);

                    FirebaseFirestore.instance
                        .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
                        .doc(box.read(KeyValue.KEY_ACCOUNT_UID))
                        .update({KeyValue.KEY_ACCOUNT_PHOTOURL: photoUrl});
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

  void updateInfo() {}
}
