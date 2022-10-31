// ignore_for_file: avoid_print, library_prefixes

import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  String data = '';
  final storage = const FlutterSecureStorage();
  String decryptAES(String str) {
    String iv = str.substring(0, 32);
    String hash = str.substring(32, 96);
    String cipherText = str.substring(96);
    return extractPayload(cipherText, iv);
  }

  String convertRadix(int from, int to, String text) {
    print(BigInt.parse(text, radix: from).toRadixString(to));
    return BigInt.parse(text, radix: from).toRadixString(to);
  }

  // ignore: non_constant_identifier_names
  String extractPayload(String cipherText, String iv_str) {
    var key = Key.fromBase16(
        '6B5970337336763979244226452948404D6351655468576D5A7134743777217A');
    final cipher = Encrypter(AES(key, mode: AESMode.cbc));
    var dec = cipher.decrypt16(cipherText, iv: IV.fromBase16(iv_str));
    return dec;
  }

  Storage(String str) {
    data = decryptAES(str);
  }
  void putKey() {
    storage.write(key: 'store', value: data);
  }

  Future<void> readKey() async {
    String? value = await storage.read(key: 'store');
    if (value != null) print(value);
  }
}
