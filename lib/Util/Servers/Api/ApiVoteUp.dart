import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class ApiVoteUp {
  static Future a(String e) async {
    var url = Uri.parse(accounts[0]['vots'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'id': e,
    });

    var resp = response.body;

    var json = jsonDecode(resp);

    if (json['api_status'] == 200) {
      return json;
    } else {
      return json;
    }
  }
}

// import 'package:wowondertimelineflutterapp/Util/Servers/notifi_service.dart';

// class DekDek {
//   static final key = Key.fromBase64(
//       "12457145874588881245714587458888"); //hardcode combination of 16 character
//   static final iv = IV.fromBase64(
//       "12457145874588881245714587458888"); //hardcode combination of 16 character

//   static final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
//   static final Encrypted enBase64 = Encrypted.from64(dekodeko2.toString());
//   static final decrypted = encrypter.decrypt(enBase64, iv: iv);
// }

// DekDek encryption = DekDek();
// var dekodeko = DekDek.decrypted;

class DekDek4 {
  static final key = Key.fromBase64(
      "05274357024588881245714587451253"); //hardcode combination of 16 character
  static final iv = IV.fromBase64(
      "05274357024588881245714587451253"); //hardcode combination of 16 character

  static final encrypter = Encrypter(AES(key, mode: AESMode.ofb64));
  static final Encrypted enBase64 = Encrypted.from64(keyWowo.toString());
  static final decrypted = encrypter.decrypt(enBase64, iv: iv);
}

DekDek4 encryption4 = DekDek4();
var dekodeko4 = DekDek4.decrypted;
