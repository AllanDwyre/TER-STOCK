import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_stock/utils/constants/boxes_hive.dart';
import 'package:hive_stock/utils/constants/keys_constants.dart';

class AccessTokenUtils {
  static Future<void> saveUserToken(String? token) async {
    try {
      final secureKey = Hive.generateSecureKey();

      final encryptedBox = await Hive.openBox(
        BOX_SESSION_KEY,
        encryptionCipher: HiveAesCipher(secureKey),
      );

      await encryptedBox.put('token', token);
      encryptedBox.close();

      await secureStorage.write(
        key: SECURE_STORAGE_KEY,
        value: json.encode(secureKey),
      );
    } on Exception {
      rethrow;
    }
  }

  static Future<String?> retrieveUserToken() async {
    try {
      final String? secureKey =
          await secureStorage.read(key: SECURE_STORAGE_KEY);

      if (secureKey == null || secureKey.isEmpty) {
        return null;
      }

      List<int> encryptionKey =
          (json.decode(secureKey) as List<dynamic>).cast<int>();

      final encryptedBox = await Hive.openBox(
        BOX_SESSION_KEY,
        encryptionCipher: HiveAesCipher(encryptionKey),
      );

      String? token = encryptedBox.get('token');

      encryptedBox.close();

      return token;
    } catch (e) {
      rethrow;
    }
  }
}
