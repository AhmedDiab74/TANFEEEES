import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';


class ApiDeleteChat {
  static Future dele({
    required String use,
  }) async {
    var url = Uri.parse(accounts[0]['deltechat'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['use']: use,
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
