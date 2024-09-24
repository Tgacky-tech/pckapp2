import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class UserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ユーザーIDを生成する関数
  String generateUserId() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(10, (index) => chars[random.nextInt(chars.length)]).join();
  }

  // ユーザーを作成する関数
  Future<void> createUserIfNotExists() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    // ユーザーが作成されていない場合、新しいユーザーを作成
    if (userId == null) {
      userId = generateUserId(); // 自動生成されたユーザーID
      String username = userId; // ユーザー名もユーザーIDと同じ

      // Firestoreにユーザーを追加
      await firestore.collection('users').doc(userId).set({
        'username': username,
        'score': 0, // 初期スコアを0に設定
      });

      // SharedPreferencesにユーザーIDを保存
      await prefs.setString('userId', userId);
    }
  }
}