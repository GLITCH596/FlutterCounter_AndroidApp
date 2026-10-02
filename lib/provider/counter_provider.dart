import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterProvider extends ChangeNotifier{
  int counter = 0;

  CounterProvider() {
    getCounterFromPrefs();
  }

  Future<void> increment() async {
    final prefs = await SharedPreferences.getInstance();

    counter++;
    notifyListeners();

    prefs.setInt('counter', counter);
  }

  Future<void> decrement() async {
    if (counter > 0) {
      final prefs = await SharedPreferences.getInstance();

      counter--;
      notifyListeners();

      prefs.setInt('counter', counter);
    }
  }

  Future<void> zeroing() async {
    if (counter != 0) {
      final prefs = await SharedPreferences.getInstance();

      counter = 0;
      notifyListeners();

      prefs.setInt('counter', counter);
    }
  }

  Future<void> getCounterFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('counter')) {

      counter = prefs.getInt('counter')!;
      notifyListeners();

    }
  }


}