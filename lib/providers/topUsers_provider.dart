import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final topUsersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firestore
      .collection('users')
      .where('score', isGreaterThan: 0) // スコアが0より大きいユーザーのみ取得
      .orderBy('score', descending: false) // スコアを昇順に並べる
      .limit(10) // 10個のドキュメントを取得
      .get();

  List<Map<String, dynamic>> topUsers = [];
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> userData = {
      'username': doc['username'],
      'score': doc['score'],
    };
    topUsers.add(userData);
  }
  return topUsers;
});