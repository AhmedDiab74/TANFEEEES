import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiReactionStories {
  static Future reaction({
    required String story_id,
    required String reaction,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['reactStor'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'id': story_id,
      'reaction': reaction,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
