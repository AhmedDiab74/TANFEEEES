import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMesageModel.dart';


class GetUserMessgesApi {
  static Future<List<GetAllMesageModel>> chat(
      String userid, String message_id) async {
    var url = Uri.parse(accounts[0]['getallc'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<GetAllMesageModel> posts = <GetAllMesageModel>[];

    var response = await http.post(url, body: {
      accounts[0]['sm1']: accounts[0]['sm2'],
      'recipient_id': userid,
      'limit': '100',
      'after_message_id': message_id,
    });

    var resp = response.body;

    var datajson = jsonDecode(resp);
    var wwwdata = datajson['messages'];

    // print('asdasdadasd '+accounts[0]['getallc']);
    // print('asdasdadasd '+userid);
    // print('asdasdadasd '+message_id);

    for (var item in wwwdata) {
      posts.add(GetAllMesageModel.fromJson(item));
    }
    return posts;
  }
}
