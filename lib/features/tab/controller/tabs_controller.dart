import 'package:flutter/material.dart';

class TabsController extends ChangeNotifier {
  int currentIndex = 0;
  int? previousTabIndex; // Track the tab user was on before navigation

  void setCurrentTabIndex({required int index}) {
    previousTabIndex = currentIndex;
    currentIndex = index;
    notifyListeners();
  }

  void restorePreviousTab() {
    if (previousTabIndex != null) {
      currentIndex = previousTabIndex!;
      notifyListeners();
    }
  }

  void clearPreviousTab() {
    previousTabIndex = null;
    notifyListeners();
  }
}
