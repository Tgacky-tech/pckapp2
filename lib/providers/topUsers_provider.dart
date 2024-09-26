import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pckapp2/providers/currentUserRank_provider.dart';
//
// final topUsersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
//   final firestore = FirebaseFirestore.instance;
//   QuerySnapshot querySnapshot = await firestore
//       .collection('users')
//       .where('score', isGreaterThan: 0) // スコアが0より大きいユーザーのみ取得
//       .orderBy('score', descending: false) // スコアを昇順に並べる
//       .limit(10) // 10個のドキュメントを取得
//       .get();
//
//   List<Map<String, dynamic>> topUsers = [];
//   for (var doc in querySnapshot.docs) {
//     Map<String, dynamic> userData = {
//       'username': doc['username'],
//       'score': doc['score'],
//     };
//     topUsers.add(userData);
//   }
//   return topUsers;
// });
final topUsersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final prefs = await SharedPreferences.getInstance();
  final currentUserId = prefs.getString('userId') ?? '';

  // 全てのユーザーをスコア順に取得
  QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .where('score', isGreaterThan: 0)
      .orderBy('score', descending: false)
      .get();

  List<Map<String, dynamic>> topUsers = [];
  int currentUserRank = -1;

  for (int i = 0; i < querySnapshot.docs.length; i++) {
    var doc = querySnapshot.docs[i];
    Map<String, dynamic> userData = {
      'username': doc['username'],
      'score': doc['score'],
      'userId': doc['userId']
    };
    print('UserID: ${userData['userId']}');
    topUsers.add(userData);

    // 現在のユーザーの順位を探す
    if (doc.id == currentUserId) {
      currentUserRank = i + 1; // 1位から数えるために+1
    }
  }

  // 上位10名を取得
  topUsers = topUsers.take(10).toList();

  // 自分の順位を最後のデータに追加
  ref.read(currentUserRankProvider.notifier).state = currentUserRank;

  return topUsers;
});