import 'dart:convert';
import 'package:crypto/crypto.dart';

class PinHasher {
  static String hashPin(String pin) {
    final bytes = utf8.encode(pin);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  static bool verifyPin(String inputPin, String hashedPin) {
    final inputHash = hashPin(inputPin);
    return inputHash == hashedPin;
  }
}
