import 'package:e_learn/model/user.dart';
import 'package:flutter/material.dart';

import '../method_provider/auth_method.dart';

class UserProvider with ChangeNotifier {
  AllUser? _user;
  final AuthMethod _authMethods = AuthMethod();
  AllUser? get getUser => _user;
  Future<void> refreshUser() async {
    AllUser? users = await _authMethods.getUserDetails();
    _user = users;
    notifyListeners();
  }
}

class ThemeModel extends ChangeNotifier {
  bool isDarkMode = false;
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
