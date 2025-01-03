import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiGoingEvent {
  static Future folow(
    String u,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    var url = Uri.parse(accounts[0]['going'] + token);
    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['eve']: u,
    });

    var resp = response.body;

    var json = jsonDecode(resp);
    print(json);
    if (json['api_status'] == 200) {
      // Get.snackbar('', json['follow_status']);
    } else {
      return json;
    }
  }
}
