import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';


class ApiSentMessageSotory {
  static Future send({
    required String user_id,
    required String text,
    required String story_id,
  }) async {
    var headers = {"Content-Type": "application/x-www-form-urlencoded"};

    var response = await http.post(
        Uri.parse(accounts[0]['senms'] + await SharedP.Get('tok')),
        headers: headers,
        body: {
      accounts[0]['sm1']: accounts[0]['sm2'],

          'message_hash_id':'message_hash_id',
          'user_id': user_id,
          'text': text,
          'story_id':story_id,
        });

    var resp = response.body;
    response.headers.addAll(headers);
    var json = jsonDecode(resp);
    print(json);

    if (json['api_status'] == 200) {
      return json;
    } else {
      return json;
    }
  }
}
