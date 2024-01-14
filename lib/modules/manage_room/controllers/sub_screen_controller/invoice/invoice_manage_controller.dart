import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';

class InvoiceManageController extends GetxController {
  var listInvoiceUnPaid = Rx<List<Map<String, dynamic>>>([]);
  var listInvoicePaid = Rx<List<Map<String, dynamic>>>([]);
  late TabController tabController;
  var isLoading = false.obs;
  var isLoadMore = false.obs;
  var page = Rx<int>(10);

  void stateChangeIndex(int index) {
    if (index == 0 && listInvoiceUnPaid.value.isEmpty) {
      getInvoiceUnPaid(false);
    } else if (index == 1 && listInvoicePaid.value.isEmpty) {
      getInvoicePaid(false);
    }
    //index == 0 ? getInvoiceUnPaid(false) : getInvoicePaid(false);
  }

  Future<void> getInvoiceUnPaid(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listInvoiceUnPaid.value = await FireStoreMethods().getListInvoice(
        FirebaseAuth.instance.currentUser!.uid,
        true,
        'PENDING',
        page.value += 10,
      );
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listInvoiceUnPaid.value.clear();
      listInvoiceUnPaid.value = await FireStoreMethods().getListInvoice(
          FirebaseAuth.instance.currentUser!.uid, true, 'PENDING', page.value);
      isLoading.value = false;
    }
  }

  Future<void> getInvoicePaid(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listInvoicePaid.value = await FireStoreMethods().getListInvoice(
        FirebaseAuth.instance.currentUser!.uid,
        true,
        'SUCCESS',
        page.value += 10,
      );
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listInvoicePaid.value.clear();
      listInvoicePaid.value = await FireStoreMethods().getListInvoice(
          FirebaseAuth.instance.currentUser!.uid, true, 'SUCCESS', page.value);
      isLoading.value = false;
    }
  }
}
