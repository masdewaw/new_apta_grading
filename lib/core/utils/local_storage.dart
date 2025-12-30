// ignore_for_file: strict_top_level_inference

import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey { accessToken, name, id, session }

String determineStorageKey(StorageKey key) {
  switch (key) {
    case StorageKey.accessToken:
      return 'access_token';
    case StorageKey.name:
      return 'name';
    case StorageKey.id:
      return 'id';
    case StorageKey.session:
      return 'session';
  }
}

addStringStorage(StorageKey key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(determineStorageKey(key), value);
}

addIntStorage(StorageKey key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(determineStorageKey(key), value);
}

getStringStorage(StorageKey key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString(determineStorageKey(key));
  return stringValue;
}

getIntStorage(StorageKey key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? stringValue = prefs.getInt(determineStorageKey(key));
  return stringValue;
}

removeStorage(StorageKey key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(determineStorageKey(key));
}
