import 'dart:convert';
import 'package:wowondertimelineflutterapp/Util/AESEncryption/AES.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetColorPostModel.dart';

class ApiGetColorPost {
  static Future<List<GetColorPostModel>> color(String colorId) async {
    var url = Uri.parse(accounts[0]['wopllkss']);
    var dir = await getTemporaryDirectory();

    List<GetColorPostModel> posts = <GetColorPostModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
    });

    var responseData = jsonDecode(response.body);
    var ameno = decryptNewsOkl(responseData['config']);
    var ss = jsonDecode(ameno);
    var wwwdata = ss['post_colors'][colorId];

    posts.add(GetColorPostModel.fromJson(wwwdata));

    return posts;
  }
}
