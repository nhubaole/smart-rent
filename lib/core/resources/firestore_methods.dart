import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
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

      // await _firestore
      //     .collection('accounts')
      //     .doc(_auth.currentUser!.uid)
      //     .set(account.toJson());

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
        print('Unliked Successfully');
      } else {
        await _firestore
            .collection(KeyValue.KEY_COLLECTION_ROOM)
            .doc(postId)
            .update({
          'listLikes': FieldValue.arrayUnion([uid]),
        });
        print('Liked Successfully');
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
