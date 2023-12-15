import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/invoice/invoice.dart';
import 'package:smart_rent/core/model/review_ticket/review_ticket.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/firebase_fcm.dart';
import 'package:smart_rent/core/values/key_value.dart';

class FireStoreMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUserFireStore(Account account) async {
    String res = 'Some error occured';
    try {
      if (_auth.currentUser == null) {
        return 'Không thể đăng ký';
      }
      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ACCOUNT)
          .doc(_auth.currentUser!.uid)
          .set(account.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(postId)
          .get();
      Map<String, dynamic>? room = querySnapshot.data();
      //print(room);
      if (room?['listLikes'].contains(uid)) {
        await _firestore
            .collection(KeyValue.KEY_COLLECTION_ROOM)
            .doc(postId)
            .update({
          'listLikes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore
            .collection(KeyValue.KEY_COLLECTION_ROOM)
            .doc(postId)
            .update({
          'listLikes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Future<Room> getRoom(String roomId) async {
    Room room = await _firestore
        .collection(KeyValue.KEY_COLLECTION_ROOM)
        .doc(roomId)
        .get()
        .then((value) => Room.fromJson(value.data()!));
    return room;
  }

  Future<String> addInvoice(Invoice invoice) async {
    String rs = 'Some thing went wrong';
    try {
      await _firestore
          .collection(KeyValue.KEY_INVOICE_COLLECTION)
          .doc(invoice.paymentLinkId)
          .set(invoice.toJson());
      rs = 'sucess';
    } catch (err) {
      rs = err.toString();
    }
    return rs;
  }

  Future<String> addReviewTicket(ReviewTicket reviewTicket) async {
    String rs = 'Some thing went wrong';
    try {
      String key = _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(reviewTicket.roomId)
          .collection(KeyValue.KEY_REVIEW_TICKET_COLLECTION)
          .doc()
          .id;
      reviewTicket = reviewTicket.copyWith(id: key);

      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(reviewTicket.roomId)
          .collection(KeyValue.KEY_REVIEW_TICKET_COLLECTION)
          .add(reviewTicket.toJson());
      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(reviewTicket.roomId)
          .update({
        'listComments': FieldValue.arrayUnion([key]),
      });
      rs = 'sucess';
    } catch (err) {
      rs = err.toString();
    }
    return rs;
  }

  Future<String> addOrderCode(Invoice invoice) async {
    String rs = 'Some thing went wrong';
    try {
      await _firestore
          .collection(KeyValue.KEY_PAYOS_REQUEST_COLLECTION)
          .doc(invoice.orderCode.toString())
          .set({
        'orderCode': invoice.orderCode,
      });
      rs = 'sucess';
    } catch (err) {
      rs = err.toString();
    }
    return rs;
  }

  Future<String> addInforRequestPayOS(
      Map<String, dynamic> request, Invoice invoice) async {
    String rs = 'Some thing went wrong';
    try {
      print('invoice.orderCode ' + invoice.orderCode.toString());
      await _firestore
          .collection(KeyValue.KEY_PAYOS_REQUEST_COLLECTION)
          .doc(invoice.orderCode.toString())
          .set({
        'orderCode': invoice.orderCode,
        'roomId': invoice.roomId,
        'recieverid': invoice.recieverId,
        'buyer': invoice.buyerId,
        'response': request,
        'invoice': invoice.toJson(),
        'timeStamp': DateTime.now()
                .add(const Duration(hours: 1))
                .toUtc()
                .millisecondsSinceEpoch ~/
            1000,
        'status': 'SUCCESS',
      }).onError(
              (error, stackTrace) => print("Error writing document: $error"));
      rs = 'sucess';
    } catch (err) {
      rs = err.toString();
    }
    return rs;
  }

  Future<String> updateInvoice(Invoice invoice, String result) async {
    String rs = 'Some thing went wrong';
    try {
      await _firestore
          .collection(KeyValue.KEY_PAYOS_REQUEST_COLLECTION)
          .doc(invoice.paymentLinkId)
          .update({'status': result});
      rs = 'sucess';
    } catch (err) {
      rs = err.toString();
    }
    return rs;
  }

  Future<int> getNewestOrderCode() async {
    int newestOrderCode = 0;
    try {
      await _firestore
          .collection(KeyValue.KEY_PAYOS_REQUEST_COLLECTION)
          .orderBy('orderCode', descending: true)
          .limit(1)
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) {
                newestOrderCode = element.data()['orderCode'] as int;
              },
            ),
          );
    } catch (err) {}
    return newestOrderCode;
  }

  Future<void> setTokenDevice(
    String uidOwner,
  ) async {
    try {
      String token = await FirebaseFCM().getCurrentToken();
      String uid =
          _firestore.collection(KeyValue.KEY_DEVICE_COLLECTION).doc().id;
      await _firestore.collection(KeyValue.KEY_DEVICE_COLLECTION).doc(uid).set({
        'uid': uid,
        'uidOwner': uidOwner,
        'token': token,
      });
    } catch (err) {
      Get.snackbar('title', err.toString());
    }
  }
}
