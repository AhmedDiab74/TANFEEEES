import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetModelStorisById.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetByIdStories {
    static Future<List<GetModelStorisById>> id(

      {required String story_id}) async {
    var url = Uri.parse(accounts[0]['byidSto'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();
    String fileName = "${story_id}storybyId.json";
    List<GetModelStorisById> posts = <GetModelStorisById>[];
    File file = new File(dir.path + "/$story_id" + fileName);
    var response = await http.post(url, body: {
            accounts[0]['sm1']: accounts[0]['sm2'],
     'id':story_id,
    });
    var resp = response.body;
    var datajson = jsonDecode(resp);
    var wwwdata = datajson['story'];
    file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
  
      posts.add(GetModelStorisById.fromJson(wwwdata));

    return posts;
  }
}
