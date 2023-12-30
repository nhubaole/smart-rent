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

  Future<List<Room>> getListRoomForHome(int index) async {
    List<Room> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .limit(index)
          .orderBy('dateTime', descending: true)
          .get();
      print('querySnapshot.docs.length: ${querySnapshot.docs.length}');
      result = querySnapshot.docs.map((e) => Room.fromJson(e.data())).toList();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<void> updateStatusRoom(String uidRoom, String status) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(uidRoom)
          .update({'status': status});
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  Future<void> updateRentedRoom(
      String uidRoom, String status, bool isRented, String rentBy) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(uidRoom)
          .update({
        'isRented': isRented,
        'rentBy': rentBy,
        'status': status,
      });
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  Future<bool> checkStatusRoom(String uidRoom, String status) async {
    bool result = false;
    try {
      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(uidRoom)
          .get()
          .then((value) {
        result = value.data()!['status'] == status;
      });
    } catch (e) {
      print('error: ${e.toString()}');
    }
    return result;
  }

  Future<void> updateRoomIsRented(String roomId, bool isRented) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(roomId)
          .update({'isRented': isRented});
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  Future<List<Room>> getManyRoomRequestRent(String uid, int index) async {
    List<Room> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .where('createdByUid', isEqualTo: uid)
          .where('status', isEqualTo: 'REQUESTRENT')
          .limit(index)
          .get();
      result = querySnapshot.docs.map((e) => Room.fromJson(e.data())).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e.toString());
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> getTicketsRequestReturn(
      String uid, int index, String status) async {
    List<Map<String, dynamic>> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_RETURN_RENT_ROOM_COLLECTION)
          .where('uidTenant', isEqualTo: uid)
          .where('status', isEqualTo: status)
          .limit(index)
          .get();

      result = querySnapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<List<Room>> getManyRoomRented(String uid, int index) async {
    List<Room> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .where('rentBy', isEqualTo: uid)
          .where('status', isEqualTo: 'RENTED')
          .limit(index)
          .get();
      result = querySnapshot.docs.map((e) => Room.fromJson(e.data())).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<List<Room>> getManyRoomPosted(String uid, int index) async {
    List<Room> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .where('createdByUid', isEqualTo: uid)
          .limit(index)
          .get();
      result = querySnapshot.docs.map((e) => Room.fromJson(e.data())).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<List<Room>> getManyRoomWithStatus(
    String uid,
    int index,
    String status,
  ) async {
    List<Room> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .where('createdByUid', isEqualTo: uid)
          .where('status', isEqualTo: status)
          .limit(index)
          .get();
      result = querySnapshot.docs.map((e) => Room.fromJson(e.data())).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<List<Room>> getLikedRoom(String uid, int index) async {
    List<Room> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .where(
            'listLikes',
            arrayContains: FirebaseAuth.instance.currentUser!.uid,
          )
          .get();
      result = querySnapshot.docs.map((e) => Room.fromJson(e.data())).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<Room> getRoomById(String roomId) async {
    Room room = await _firestore
        .collection(KeyValue.KEY_COLLECTION_ROOM)
        .doc(roomId)
        .get()
        .then((value) => Room.fromJson(value.data()!));
    return room;
  }

  Future<List<Room>> getListRoomFromListId(List<String> list) async {
    List<Room> roomList = [];
    try {
      for (var i in list) {
        Room room = await getRoomById(i);
        roomList.add(room);
      }
    } catch (e) {
      print(e.toString());
    }
    return roomList;
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
          .collection(KeyValue.KEY_TICKET_REVIEW_COLLECTION)
          .doc()
          .id;
      reviewTicket = reviewTicket.copyWith(id: key);

      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(reviewTicket.roomId)
          .collection(KeyValue.KEY_TICKET_REVIEW_COLLECTION)
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
        'statusInvoice': 'PENDING',
      }).onError(
        (error, stackTrace) => print("Error writing document: $error"),
      );
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
          .doc(invoice.orderCode.toString())
          .update({'statusInvoice': result});
      await _firestore
          .collection(KeyValue.KEY_PAYOS_REQUEST_COLLECTION)
          .doc(invoice.orderCode.toString())
          .update({'response.data.status': result});
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
      // String uid =
      //     _firestore.collection(KeyValue.KEY_DEVICE_COLLECTION).doc().id;
      await _firestore
          .collection(KeyValue.KEY_DEVICE_COLLECTION)
          .doc(uidOwner)
          .set({
        // 'uid': uid,
        'uidOwner': uidOwner,
        'token': token,
      });
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
  }

  Future<String> getTokenDevice(String uidOwner) async {
    String token = '';
    try {
      await _firestore
          .collection(KeyValue.KEY_DEVICE_COLLECTION)
          .doc(uidOwner)
          .get()
          .then((value) => token = value.data()!['token']);
    } catch (err) {
      Get.snackbar('Error', err.toString());
    }
    print(token);
    return token;
  }

  Future<void> setContentNotification(
    String uidOwner,
    Map<String, dynamic> data,
  ) async {
    try {
      String id =
          _firestore.collection(KeyValue.KEY_DEVICE_COLLECTION).doc().id;
      data['id'] = id;
      await _firestore
          .collection(KeyValue.KEY_NOTIFICATION_COLLECTION)
          .doc(id)
          .set(data);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<Map<String, dynamic>> getpOneNewestInvoice(
    String roomId,
    String buyer,
    bool descending,
  ) async {
    Map<String, dynamic> invoice = {};
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(KeyValue.KEY_PAYOS_REQUEST_COLLECTION)
          .where('buyer', isEqualTo: buyer)
          .orderBy('timeStamp', descending: descending)
          .limit(1)
          .get();

      invoice = querySnapshot.docs.first.data() as Map<String, dynamic>;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return invoice;
  }

  Future<List<Map<String, dynamic>>> getListInvoice(
    String uid,
    bool descending,
    String statusInvoice,
    int page,
  ) async {
    List<Map<String, dynamic>> listInvoice = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(KeyValue.KEY_PAYOS_REQUEST_COLLECTION)
          .where('buyer', isEqualTo: uid)
          .where('statusInvoice', isEqualTo: statusInvoice)
          .orderBy(
            'timeStamp',
            descending: descending,
          )
          .limit(page)
          .get();
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        listInvoice.add(documentData);
      }
    } catch (err) {
      print(err.toString());
    }
    return listInvoice;
  }

  Future<List<Map<String, dynamic>>> getListNotification(
    String uidOwner,
    int page,
  ) async {
    List<Map<String, dynamic>> listNotification = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(KeyValue.KEY_NOTIFICATION_COLLECTION)
          .where('data.recieverId', isEqualTo: uidOwner)
          .orderBy('timeStamp', descending: true)
          .limit(page)
          .get();
      print('querySnapshot.docs.length: ${querySnapshot.docs.length}');
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        listNotification.add(documentData);
      }
    } catch (err) {
      print(err.toString());
    }

    return listNotification;
  }

  Future<void> markAsReadNotification(String id) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_NOTIFICATION_COLLECTION)
          .doc(id)
          .update({'isRead': true});
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  Future<bool> isRented(String uidOwner, String uidRoom) async {
    bool isRented = false;
    try {
      await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(uidRoom)
          .get()
          .then((value) {
        isRented = value.data()!['status'] == 'RENTED';
      });
    } catch (e) {
      print('error: ${e.toString()}');
    }
    return isRented;
  }

  Future<String> sendTicketRequestReturnRent(Map<String, dynamic> data) async {
    String rs = 'Some thing went wrong';
    try {
      await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_RETURN_RENT_ROOM_COLLECTION)
          .doc(data['id'])
          .set(data);

      rs = 'success';
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rs = e.toString();
    }
    return rs;
  }

  Future<String> updateTicketRequestReturnRent(
    String ticketId,
    Map<String, dynamic> data,
  ) async {
    String rs = 'Some thing went wrong';
    try {
      await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_RETURN_RENT_ROOM_COLLECTION)
          .doc(ticketId)
          .update(data);

      rs = 'success';
    } catch (e) {
      Get.snackbar('Error', e.toString());
      rs = e.toString();
    }
    return rs;
  }

  Future<Map<String, dynamic>> getTicketRequestReturnRent(
    String uidLandlord,
    String roomId,
    String status,
  ) async {
    Map<String, dynamic> result = {};
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_RETURN_RENT_ROOM_COLLECTION)
          .where('uidLandlord', isEqualTo: uidLandlord)
          .where('roomId', isEqualTo: roomId)
          .where('status', isEqualTo: status)
          .orderBy('timeStamp', descending: true)
          .limit(1)
          .get();
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        result = documentData;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<String> getTicketRequestReturnRentId(
    String roomId,
    String uidLandlord,
    String uidTenant,
  ) async {
    String status = '';
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_RETURN_RENT_ROOM_COLLECTION)
          .where('uidLandlord', isEqualTo: uidLandlord)
          .where('uidTenant', isEqualTo: uidTenant)
          .where('roomId', isEqualTo: roomId)
          .orderBy('timeStamp', descending: true)
          .limit(1)
          .get();
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        status = documentData['id'];
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return status;
  }

  Future<void> updateStatusTicketRequestReturnRent(
    String ticketId,
    String status,
  ) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_RETURN_RENT_ROOM_COLLECTION)
          .doc(ticketId)
          .update({'status': status});
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  Future<String> getDocumentId(String collection) async {
    return _firestore.collection(collection).doc().id;
  }

  // Future<void> addReviewRoom(String roomId, Map<String, dynamic> data) async {
  //   try {
  //     await _firestore
  //         .collection(KeyValue.KEY_TICKET_REVIEW_COLLECTION)
  //         .doc(roomId)
  //         .set(data);
  //   } catch (e) {
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

  Future<Map<String, dynamic>> getListReviews(String roomId, int page) async {
    Map<String, dynamic> data = {}; // Initialize data as an empty map
    double sumRating = 0;
    int counterFiveStars = 0;
    int counterFourStars = 0;
    int counterThreeStars = 0;
    int counterTwoStars = 0;
    int counterOneStars = 0;
    try {
      var querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .doc(roomId)
          .collection(KeyValue.KEY_TICKET_REVIEW_COLLECTION)
          .limit(page)
          .get();
      querySnapshot.docs.forEach((element) {
        print(element.data());
      });

      var reviews = querySnapshot.docs.map((e) {
        var rating = e.data()['rating'];
        if (rating > 4) counterFiveStars++;
        if (rating > 3 && rating <= 4) counterFourStars++;
        if (rating > 2 && rating <= 3) counterThreeStars++;
        if (rating > 1 && rating <= 2) counterTwoStars++;
        if (rating > 0 && rating <= 1) counterOneStars++;

        sumRating += rating;
        return e.data();
      }).toList();

      data['list'] = reviews;
      data['sumRating'] = sumRating;
      data['counterFiveStars'] = counterFiveStars;
      data['counterFourStars'] = counterFourStars;
      data['counterThreeStars'] = counterThreeStars;
      data['counterTwoStars'] = counterTwoStars;
      data['counterOneStars'] = counterOneStars;
    } catch (e) {
      print(e.toString());
    }

    return data;
  }

  Future<int> getCountReview(String roomId) async {
    int count = 0;
    try {
      await _firestore
          .collection(KeyValue.KEY_TICKET_REVIEW_COLLECTION)
          .doc(roomId)
          .get()
          .then((value) {
        count = value.data()!['listReview'].length;
      });
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return count;
  }

  Future<String> sendTicketRequestRent(
    String id,
    Map<String, dynamic> data,
  ) async {
    String rs = 'Something when wrong';
    try {
      await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_REQUEST_RENT_ROOM_COLLECTION)
          .doc(id)
          .set(data);
      rs = 'success';
    } catch (e) {
      rs = e.toString();
      print(e.toString());
    }
    return rs;
  }

  Future<List<Map<String, dynamic>>> getTicketsRequestRent(
    String uidTenant,
    int index,
    String status,
  ) async {
    List<Map<String, dynamic>> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_REQUEST_RENT_ROOM_COLLECTION)
          .where('uidTenant', isEqualTo: uidTenant)
          .where('status', isEqualTo: status)
          .limit(index)
          .get();

      result = querySnapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<List<Map<String, dynamic>>> getTicketsHandleRequestRent(
    String uidLandlord,
    int index,
    String status,
  ) async {
    List<Map<String, dynamic>> result = [];
    try {
      final querySnapshot = await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_REQUEST_RENT_ROOM_COLLECTION)
          .where('uidLandlord', isEqualTo: uidLandlord)
          .where('status', isEqualTo: status)
          .limit(index)
          .get();

      result = querySnapshot.docs.map((e) => e.data()).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<Map<String, dynamic>> getTicketRequestRent(
    String uidTenant,
    String roomId,
    String status,
  ) async {
    Map<String, dynamic> result = {};
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_REQUEST_RENT_ROOM_COLLECTION)
          .where('uidTenant', isEqualTo: uidTenant)
          .where('roomId', isEqualTo: roomId)
          .where('status', isEqualTo: status)
          .orderBy('timeStamp', descending: true)
          .limit(1)
          .get();
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        result = documentData;
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return result;
  }

  Future<void> updateStausTicketRequestRent(
    String ticketId,
    String status,
  ) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_TICKET_REQUEST_REQUEST_RENT_ROOM_COLLECTION)
          .doc(ticketId)
          .update({'status': status});
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  // MANAGE ROOM RENTING AND HISTORY ROOM

  Future<void> addRentingRoomId(
    String uid,
    String roomId,
  ) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_HISTORY_RENT_ROOM_COLLECTION)
          .doc(uid)
          .set({
        'listRentingRoom': [roomId],
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> removeRentingRoomId(
    String uid,
    String roomId,
  ) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_HISTORY_RENT_ROOM_COLLECTION)
          .doc(uid)
          .update({
        'listRentingRoom': FieldValue.arrayRemove([roomId]),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addHistoryRoomId(
    String uid,
    String roomId,
  ) async {
    try {
      await _firestore
          .collection(KeyValue.KEY_HISTORY_RENT_ROOM_COLLECTION)
          .doc(uid)
          .set({
        'listHistoryRoom': [roomId],
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> getRentingRoom(
    String uid,
    int index,
  ) async {
    List<String> listRoom = [];
    try {
      await _firestore
          .collection(KeyValue.KEY_HISTORY_RENT_ROOM_COLLECTION)
          .doc(uid)
          .get()
          .then((value) {
        List<dynamic>? dynamicList = value.data()?['listRentingRoom'];

        if (dynamicList != null) {
          listRoom =
              dynamicList.map((dynamic item) => item.toString()).toList();
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return listRoom;
  }

  Future<List<String>> getHistoryRoom(
    String uid,
    int index,
  ) async {
    List<String> listRoom = [];
    try {
      await _firestore
          .collection(KeyValue.KEY_HISTORY_RENT_ROOM_COLLECTION)
          .doc(uid)
          .get()
          .then((value) {
        List<dynamic>? dynamicList = value.data()?['listHistoryRoom'];

        if (dynamicList != null) {
          listRoom =
              dynamicList.map((dynamic item) => item.toString()).toList();
        }
      });
    } catch (e) {
      print(e.toString());
    }

    return listRoom;
  }

  Future<List<Map<String, dynamic>>> getListTenant(
      String landLordUid, int page) async {
    List<Map<String, dynamic>> listTenant = [];
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(KeyValue.KEY_COLLECTION_ROOM)
          .where('createdByUid', isEqualTo: landLordUid)
          .where('isRented', isEqualTo: true)
          .orderBy('dateTime', descending: true)
          .limit(page)
          .get();
      for (var document in querySnapshot.docs) {
        Map<String, dynamic> documentData =
            document.data() as Map<String, dynamic>;
        listTenant.add(documentData);
      }
    } catch (e) {
      print(e.toString());
    }
    return listTenant;
  }
}
