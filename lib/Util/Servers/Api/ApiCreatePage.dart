import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
// ApiCreatePage


class ApiCreatePage {
  static Future create(
    String page_name,
    String page_title,
    String page_category,
    String page_description,
  ) async {
    var url = Uri.parse(accounts[0]['pgc'] + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'page_name': page_name,
      'page_title': page_title,
      'page_category': page_category,
      'page_description': page_description,
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
