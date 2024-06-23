import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiVoteUp.dart';

class StroeReditect {
  static const MethodChannel _channel = const MethodChannel('store_redirct');

  static Future<void> redirct(
      {String? androidAppId, String, String? IOSAppId}) async {
    await _channel.invokeMethod(
        'redirct', {'adnroid_id': androidAppId, 'ios_id': IOSAppId});
    return null;
  }
}

class DekDek2 {
  static final key = Key.fromBase64(
      "12457145874588881245714587451253"); //hardcode combination of 16 character
  static final iv = IV.fromBase64(
      "12457145874588881245714587451253"); //hardcode combination of 16 character

  static final encrypter = Encrypter(AES(key, mode: AESMode.ofb64));
  static final Encrypted enBase64 = Encrypted.from64(dekodeko4.toString());
  static final decrypted = encrypter.decrypt(enBase64, iv: iv);
}
