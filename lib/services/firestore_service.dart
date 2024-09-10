import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(String userId, String userName, int clearTime) async {
    await _firestore.collection('users').doc(userId).set({
      'userName': userName,
      'clearTime': clearTime,
    });
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getTopClearTimes(int limit) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')  // 'users' コレクションから
        .orderBy('clearTime')  // 'clearTime' で昇順に並べる
        .limit(limit)  // 指定した数 (limit) だけ取得する
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}

