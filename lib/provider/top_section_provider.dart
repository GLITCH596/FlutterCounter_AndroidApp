import 'package:flutter/material.dart';

class TopSectionProvider extends ChangeNotifier{
  bool activity = true;

  void toggleActivity(bool toggle) {
    if (toggle != activity) {
      activity = toggle;
      notifyListeners();
    }
  }
}