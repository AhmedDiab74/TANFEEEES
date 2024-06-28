import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';


class ApiLikePage {
  static Future like(
      String page_id,
      ) async {
    var url = Uri.parse(accounts[0]['likeP'] + await SharedP.Get('tok'));

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'page_id': page_id,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);

    // print(posts);
    return datajson;
  }
}
