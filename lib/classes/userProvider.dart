import 'package:flutter/material.dart';
import 'package:auxigym/database/db.dart';

class UserProvider extends ChangeNotifier {
  int? userId;
  String? nomeUsuario;

  Future<void> setUser(int id) async {
    userId = id;
    nomeUsuario = await DatabaseHelper.instance.getUsername(userId!);
    notifyListeners();
  }
}
