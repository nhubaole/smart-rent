import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '/core/model/account/Account.dart';
import '/core/resources/auth_methods.dart';
import '/core/values/KEY_VALUE.dart';

class ProfileOwnerController extends GetxController {
  final String uidOwner;
  ProfileOwnerController({required this.uidOwner});
  var profileOwner = Rx<Account?>(null);
  var isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<RoomModel> listRoom = <RoomModel>[].obs;

  @override
  void onInit() {
    getProfile(uidOwner);
    getListRoom();
    super.onInit();
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListRoom() async {
    
  }
}
