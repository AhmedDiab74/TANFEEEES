import 'dart:convert';

import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetFollo {
  static Future<List<GetAllFrindsModel>> get(
      {required String user_id,
      required String following_offset,
      required String typeGet}) async {
    var url = Uri.parse(accounts[0]['getf'] + await SharedP.Get('tok'));

    List<GetAllFrindsModel> posts = <GetAllFrindsModel>[];

    try {
      var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
        'type': 'followers,following',
        'user_id': await SharedP.Get('user_id'),
        'limit': '10',
        if (typeGet == 'following') 'following_offset': following_offset,
        if (typeGet == 'followers') 'followers_offset': following_offset,
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['data'][typeGet];
      for (var item in wwwdata) {
        posts.add(GetAllFrindsModel.fromJson(item));
      }

      return posts;
    } catch (e) {
      print('لا يوجد انترنت');
    }

    return posts;
  }
}
