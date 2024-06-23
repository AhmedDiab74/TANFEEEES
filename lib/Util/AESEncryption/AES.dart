import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';

import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLoading/html_shim.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class AESEncryption {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  decryptMsg(encrypt.Encrypted text) => encrypter.decrypt(text, iv: iv);

  getCode(String encoded) => encrypt.Encrypted.fromBase16(encoded);
}

AESEncryption encryption = AESEncryption();
var decrypted = encryption.decryptMsg(encryption.getCode(dekodeko));





String decryptNewsOkl(String encrypted) {
  final key =
      Key.fromUtf8(accounts[0]['prt']); //hardcode combination of 16 character
  final iv =
      IV.fromUtf8("e16ce888a20dadb8"); //hardcode combination of 16 character
  final encrypter = Encrypter(AES(
    key,
    mode: AESMode.ecb,
  ));
  Encrypted enBase64 = Encrypted.from64(encrypted);
  final decrypted = encrypter.decrypt(enBase64, iv: iv);
  return decrypted;
}
