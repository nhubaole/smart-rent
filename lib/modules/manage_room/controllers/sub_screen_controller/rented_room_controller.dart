import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class RentedRoomController extends GetxController {
  var listRentingRoom = Rx<List<Room>>([]);
  var listHistoryRoom = Rx<List<Room>>([]);
  var listHistoryRoomString = Rx<List<String>>([]);

  late TabController tabController;

  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var profileOwner = Rx<Account?>(null);
  var page = Rx<int>(10);

  @override
  void onInit() {
    // getListRentingRoom(false);
    // getListHistoryRoom(false);
    getProfile(FirebaseAuth.instance.currentUser!.uid);
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
      listRentingRoom.value = await FireStoreMethods().getManyRoomRented(
        FirebaseAuth.instance.currentUser!.uid,
        page.value += 10,
      );

      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listRentingRoom.value.clear();
      listRentingRoom.value = await FireStoreMethods().getManyRoomRented(
        FirebaseAuth.instance.currentUser!.uid,
        page.value,
      );
      isLoading.value = false;
    }
  }

  Future<void> getListHistoryRoomMap(String roomId) async {
    isLoading.value = true;
    listHistoryRoom.value.add(await FireStoreMethods().getRoomById(
      roomId,
    ));
    isLoading.value = false;
  }

  Future<void> getListHistoryRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listHistoryRoom.value.clear();
      listHistoryRoomString.value = await FireStoreMethods().getHistoryRoom(
        FirebaseAuth.instance.currentUser!.uid,
        page.value += 10,
      );

      for (var i = 0; i < listHistoryRoomString.value.length; i++) {
        await getListHistoryRoomMap(listHistoryRoomString.value[i]);
      }
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listHistoryRoom.value.clear();
      listHistoryRoomString.value.clear();
      listHistoryRoomString.value = await FireStoreMethods().getHistoryRoom(
        FirebaseAuth.instance.currentUser!.uid,
        page.value,
      );
      for (var i = 0; i < listHistoryRoomString.value.length; i++) {
        await getListHistoryRoomMap(listHistoryRoomString.value[i]);
      }
      isLoading.value = false;
    }
  }
}
