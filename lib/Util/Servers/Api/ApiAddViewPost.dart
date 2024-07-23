// ApiCreatePage
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';


class ApiAddViewsVideo {
  static Future add(
    String post_id,
  ) async {
    var url = Uri.parse(accounts[0]['onep'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
  accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ft']: 'fetch',
      'add_view': '1',
          accounts[0]['pos']: post_id,
    });

    var resp = response.body;

    var json = jsonDecode(resp);
    print(json);
    if (json['api_status'] == 200) {
      return json;
    } else {
      return json;
    }
  }
}