import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';


class ApiUpdataNorifactions {
  static Future UpdateUserData({
    required String vals,
    required String nump,
  }) async {
    var url = Uri.parse(accounts[0]['usUp'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      vals: nump,
    });

    var resp = response.body;

    var json = jsonDecode(resp);

    if (json['api_status'] == 200) {
      print(json);
    } else {
      return json;
    }
  }
}
