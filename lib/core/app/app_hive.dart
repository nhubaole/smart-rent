import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() => _instance;

  HiveManager._internal();

  late Box _box;

  Future<void> init(String boxName) async {
    await Hive.initFlutter();
    _box = await Hive.openBox(boxName);
  }

  Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
  }

  dynamic get(String key) {
    return _box.get(key);
  }

  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
