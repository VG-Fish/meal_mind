import 'package:shared_preferences/shared_preferences.dart';

class ListLocalStorage {
  Future<void> addValueToKey(String key, String term) async {
    final preferences = await SharedPreferences.getInstance();

    final history = preferences.getStringList(key) ?? [];
    history.add(term);
    await preferences.setStringList(key, history);
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
