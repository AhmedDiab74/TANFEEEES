import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FetchUserViewStories.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetUserViewStories {
  static Future<List<FetchUserViewStories>> get({required String story_id,}) async {
    var url = Uri.parse(accounts[0]['getstor'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<FetchUserViewStories> stor = <FetchUserViewStories>[];

    var response = await http.post(url, body: {
    accounts[0]['sm1']: accounts[0]['sm2'],
      'story_id':story_id,

    });

    var resp = response.body;
    var datajson = jsonDecode(resp);
    print(datajson);
    var wwwdata = datajson['users'];

    for (var item in wwwdata) {
      stor.add(FetchUserViewStories.fromJson(item));
    }

    return stor;
  }
}

// Future putData(data) async {
//   await box.clear();
//   for (var d in data) {
//     box.add(data);
//   }
// }

