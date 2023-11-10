import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';

class PostReviewController extends GetxController {
  var counter = 13.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;
  RxList<Room> listRoom = <Room>[].obs;
  var profileOwner = Rx<Account?>(null);
}
