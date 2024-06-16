import 'package:flutter/material.dart';

class NavbarSelectionProvider with ChangeNotifier {
  int _selectedIndex = 0;
  late PageController _pageController;

  NavbarSelectionProvider() {
    _pageController = PageController(initialPage: _selectedIndex);
    _pageController.addListener(_onPageChanged);
  }

  int get selectedIndex => _selectedIndex;
  PageController get pageController => _pageController;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void _onPageChanged() {
    if (_pageController.page!.round() != _selectedIndex) {
      setSelectedIndex(_pageController.page!.round());
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }
}
