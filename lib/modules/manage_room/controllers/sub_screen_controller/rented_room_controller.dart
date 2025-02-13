import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '/core/model/account/Account.dart';
import '/core/resources/auth_methods.dart';

class RentedRoomController extends GetxController {
  var listRentingRoom = Rx<List<RoomModel>>([]);
  var listHistoryRoom = Rx<List<RoomModel>>([]);
  var listHistoryRoomString = Rx<List<String>>([]);

  late TabController tabController;

  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var profileOwner = Rx<Account?>(null);
  var page = Rx<int>(10);

  @override
  void onInit() {
    getListHistoryRoom(false);
    super.onInit();
  }

  void stateChangeIndex(int index) {
    if (index == 0 && listRentingRoom.value.isEmpty) {
      getListRentingRoom(false);
    } else if (index == 1 && listHistoryRoom.value.isEmpty) {
      getListHistoryRoom(false);
    }
    //index == 0 ? getInvoiceUnPaid(false) : getInvoicePaid(false);
  }

  Future<void> getProfile(String uid) async {
    isLoading.value = true;
    profileOwner.value = await AuthMethods.getUserDetails(uid);
    isLoading.value = false;
  }

  Future<void> getListRentingRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;

      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listRentingRoom.value.clear();

      isLoading.value = false;
    }
  }

  Future<void> getListHistoryRoomMap(String roomId) async {
    isLoading.value = true;

    isLoading.value = false;
  }

  Future<void> getListHistoryRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listHistoryRoom.value.clear();

      for (var i = 0; i < listHistoryRoomString.value.length; i++) {
        await getListHistoryRoomMap(listHistoryRoomString.value[i]);
      }
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listHistoryRoom.value.clear();
      listHistoryRoomString.value.clear();

      for (var i = 0; i < listHistoryRoomString.value.length; i++) {
        await getListHistoryRoomMap(listHistoryRoomString.value[i]);
      }
      isLoading.value = false;
    }
  }
}
