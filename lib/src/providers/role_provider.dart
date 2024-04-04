import 'package:flutter/material.dart';

class RoleProvider extends ChangeNotifier {
  String _selectedRole = 'member';

  String get selectedRole => _selectedRole;

  void setSelectedRole(String value) {
    _selectedRole = value;
    notifyListeners();
  }
}
