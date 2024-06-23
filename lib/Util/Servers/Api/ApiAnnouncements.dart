import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiAnnouncements {
  static Future Cre() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['annouc'] + token);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
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
