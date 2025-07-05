import 'package:shared_preferences/shared_preferences.dart';

class ListLocalStorage {
  Future<void> addValueToKey(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    final existing = preferences.getStringList(key) ?? [];
    existing.add(value);
    await preferences.setStringList(key, existing);
  }

  Future<void> removeValueFromKey(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    final existing = preferences.getStringList(key) ?? [];
    existing.remove(value);
    await preferences.setStringList(key, existing);
  }

  Future<List<String>> getKey(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(key) ?? [];
  }

  Future<void> clearKey(String key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }
}
