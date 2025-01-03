import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

// late Box box;

// Future openBox() async {
//   var dri = await getApplicationSupportDirectory();
//   Hive.init(dri.path);
//   box = await Hive.openBox('data22');
// }

class ApiReels {
  static Future<List<PostModel>> Getposts(String after_post_id) async {
    String fileName = "VideosReels.json";

    var url = Uri.parse(accounts[0]['poso'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    File file = new File(dir.path + "/" + fileName);
    List<PostModel> posts = <PostModel>[];

    // try {
    var response = await http.post(url, body: {
            accounts[0]['sm1']: accounts[0]['sm2'],
      'type': 'get_random_videos_reels',
      'after_post_id': after_post_id,
      'limit': '5',
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['data'];
    print(wwwdata);
    for (var item in wwwdata) {
      posts.add(PostModel.fromJson(item));
    }
    print(response);
    print(posts);
    return posts;
  }
}
