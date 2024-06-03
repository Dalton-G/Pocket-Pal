import 'package:flutter/material.dart';

class AuthPageProvider with ChangeNotifier {
  bool _showLoginPage = true;

  bool get showLoginPage => _showLoginPage;

  void toggleScreen() {
    _showLoginPage = !_showLoginPage;
    notifyListeners();
  }
}
