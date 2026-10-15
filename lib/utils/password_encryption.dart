import 'dart:convert';

class PasswordEncryption {
  static String encryptPassword(String password) {
    return base64Encode(utf8.encode(password));
  }
}