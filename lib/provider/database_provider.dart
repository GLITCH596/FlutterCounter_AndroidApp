import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../models/dhikr.dart';

// Hive - схема работы
// 1 - открыть бокс
// 2 - записать данные в бокс (задать ключ или инкремент key)
// 3 - позаботится о том, чтоб бокс был закрыт позднее

class DatabaseProvider extends ChangeNotifier{
  late Box<Dhikr> box;

  Future<void> openDhikrBox() async {
    box = await Hive.openBox('dhikrs');
  }

  void addDhikr(Dhikr dhikr) {
    box.add(dhikr);
    notifyListeners();
  }

  void removeDhikr(int index) {
    box.deleteAt(index);
    notifyListeners();
  }

  void updateDhikr(int index, Dhikr newDhikr) {
    box.putAt(index, newDhikr);
    notifyListeners();
  }

  void updateDatabase() {
    notifyListeners();
  }

  @override
  void dispose() {
    box.close();
    super.dispose();
  }
}