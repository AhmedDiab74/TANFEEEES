import 'dart:io';
import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FetchRecommendedModel.dart';



class ApiFetchRecommended {
  static Future<List<FetchRecommendedModel>> getUserData(
      {required String type}) async {
    String fileName = "myPostsCash55.json";

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');

    var url = Uri.parse(accounts[0]['rerer'] + token);
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    List<FetchRecommendedModel> posts = <FetchRecommendedModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['ty']: type,
      accounts[0]['li']: Recommended_friend,
    });
    var resp = response.body;

    var datajson = jsonDecode(resp);
    print(datajson);
    var data = datajson['data'];
    print('alksjdklsakldjsakldjaskldj $data');
    if (datajson['api_status'] == 200) {
      for (var item in data) {
        posts.add(FetchRecommendedModel.fromJson(item));
      }

      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    }
    return posts;
  }
}
