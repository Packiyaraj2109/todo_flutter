import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageConst {
  static final StorageConst _storageConst = StorageConst._();

  factory StorageConst() => _storageConst;

  FlutterSecureStorage _storage;

  StorageConst._() {
    init();
  }

  void init() {
    _storage = const FlutterSecureStorage();
  }

  storageread(String listname) async {
    dynamic fetchedData = await _storage.read(key: listname);
    return fetchedData;
  }

  Future<void> storagewrite(String listname, List data) async {
    await _storage.write(key: listname, value: json.encode(data));
  }

  Future<void> storagedelete(String listname) async {
    await _storage.delete(key: listname);
  }
}

class AppStorage {
  static final AppStorage _appStorage = AppStorage._();

  factory AppStorage() => _appStorage;

  AppStorage._() {
    init();
  }
  static FlutterSecureStorage _secureStorage;
  void init() {
    _secureStorage = const FlutterSecureStorage();
  }

  Future<bool> setData(String key, dynamic data) async {
    final String dataStringify = json.encode(data);
    await _secureStorage.write(key: key, value: dataStringify);
    return true;
  }

  Future<dynamic> getData(String key) async {
    final String data = await _secureStorage.read(key: key);
    return data != null ? (json.decode(data)) : null;
  }

  Future<dynamic> removeData(String key) async {
    await _secureStorage.delete(key: key);
    return true;
  }
}
