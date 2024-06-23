import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FechBlogsModel.dart';
// ApiFetchBlogs


class ApiFetchBlogs {
  static Future<List<FechBlogsModel>> Fetch() async {
    var url = Uri.parse(accounts[0]['fetblo']);

    List<FechBlogsModel> posts = <FechBlogsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['use']: await SharedP.Get(accounts[0]['use']),
      's': await SharedP.Get('tok'),
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    print(datajson);
    var data = datajson['blogs'];

    for (var item in data) {
      posts.add(FechBlogsModel.fromJson(item));
    }

    return posts;
  }
}

class ApiFetchBlogsById {
  static Future<List<FechBlogsModel>> Fetch({required String blog_id}) async {
    var url = Uri.parse(accounts[0]['blogid'] + await SharedP.Get('tok'));

    List<FechBlogsModel> posts = <FechBlogsModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'blog_id': blog_id,
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    print(datajson);
    var data = datajson['data'];

    posts.add(FechBlogsModel.fromJson(data));

    return posts;
  }
}
