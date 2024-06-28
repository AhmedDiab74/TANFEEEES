import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiUpdataAvatCoverPage {
  static uplde({avat, cover, required String page_id}) async {
    var headers = {
      'Cookie':
          '_us=1708463904; ad-con=%7B%26quot%3Bdate%26quot%3B%3A%26quot%3B2024-02-19%26quot%3B%2C%26quot%3Bads%26quot%3B%3A%5B%5D%7D; PHPSESSID=a99ro3gg6affdcs1kb7mnoiigk; _us=1708284162; ad-con=%7B%26quot%3Bdate%26quot%3B%3A%26quot%3B2024-02-17%26quot%3B%2C%26quot%3Bads%26quot%3B%3A%5B%5D%7D; mode=day; src=1'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['updp'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['pgid']: page_id,
    });
    if (avat != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        avat,
        contentType: new MediaType('image', 'png'),
      ));
    }
    if (cover != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'cover',
        cover,
        contentType: new MediaType('image', 'png'),
      ));
    }

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.snackbar('', 'Succeeded');
    } else {
      print(response.reasonPhrase);
    }
  }
}
