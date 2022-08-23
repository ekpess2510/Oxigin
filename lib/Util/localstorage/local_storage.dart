import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageItems{
  final _secureStorage = const FlutterSecureStorage();

  writeStorage(String key, String value) async{
    await _secureStorage.write(key: key, value: value, aOptions: _getAndroidOptions());
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<String> readStorage(String key) async{
    var data = await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return data!;
  }

  deleteStorage(String key ) async{
    await _secureStorage.delete(key: key);
  }
}