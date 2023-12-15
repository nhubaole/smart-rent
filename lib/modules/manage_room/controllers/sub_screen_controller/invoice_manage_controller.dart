import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class InvoiceManageController extends GetxController {
  var listInvoice = Rx<List<Map<String, dynamic>>>([]);
  late TabController tabController;
  var isLoading = false.obs;

  void stateChangeIndex(int index) {
    index == 0 ? getInvoiceUnPaid() : getInvoicePaid();
  }

  Future<void> getInvoiceUnPaid() async {
    isLoading.value = true;
    listInvoice.value = await FireStoreMethods().getListInvoice(
        FirebaseAuth.instance.currentUser!.uid, true, 'PENDING');
    //Get.snackbar('title', listInvoice.length.toString());
    isLoading.value = false;
  }

  Future<void> getInvoicePaid() async {
    isLoading.value = true;
    listInvoice.value = await FireStoreMethods().getListInvoice(
        FirebaseAuth.instance.currentUser!.uid, true, 'SUCCESS');
    //Get.snackbar('title', listInvoice.length.toString());
    isLoading.value = false;
  }
}
