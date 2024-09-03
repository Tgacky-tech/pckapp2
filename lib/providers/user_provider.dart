import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<MySqlConnection> _getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root', // MySQLのユーザー名
      password: 'password', // MySQLのパスワード
      db: 'flutter_db', // 使用するデータベース名
    );
    return await MySqlConnection.connect(settings);
  }

  Future<void> fetchUser(int id) async {
    final conn = await _getConnection();
    var results = await conn.query('SELECT * FROM users WHERE id = ?', [id]);

    if (results.isNotEmpty) {
      _user = User.fromMap(results.first.fields);
      notifyListeners();
    } else {
      throw Exception('Failed to load user');
    }
    await conn.close();
  }

  Future<void> addUser(String username, int score) async {
    final conn = await _getConnection();
    await conn.query('INSERT INTO users (username, score) VALUES (?, ?)', [username, score]);
    notifyListeners();
    await conn.close();
  }

  Future<void> updateUser(int id, String username, int score) async {
    final conn = await _getConnection();
    await conn.query('UPDATE users SET username = ?, score = ? WHERE id = ?', [username, score, id]);
    notifyListeners();
    await conn.close();
  }
}