import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _pinKey = 'pin';

  Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  Future<String?> getPin() async {
    final pin = await _storage.read(key: _pinKey);
    return pin;
  }

  Future<void> deletePin() async {
    await _storage.delete(key: _pinKey);
  }

  Future<bool> hasPin() async {
    final pin = getPin();
    // ignore: unnecessary_null_comparison
    return pin != null; 
  }
}