import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() => _instance;

  HiveManager._internal();

  static late Box _box;

  static Future<void> init(String boxName) async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  static Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
  }

  static dynamic get(String key) {
    return _box.get(key);
  }

  static Future<void> delete(String key) async {
    await _box.delete(key);
  }

  static Future<void> clear() async {
    await _box.clear();
  }
}
