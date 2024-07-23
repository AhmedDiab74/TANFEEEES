import 'dart:async';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiCreateReels {
  static Future cratepost({
    required String pathvideo,
    required String filename,
  }) async {
    print('klasjdkasjdkjsakdjaskldja ${pathvideo}');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    Map<String, String> hide = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['newposts'] + token.toString()));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'is_reel': '1',
    });
    request.headers.addAll(hide);

    if (await pathvideo == null) {
      null;
    } else {
      Get.snackbar(
          '', 'The video is uploading. We will inform you when it is finished');
      //  true
      //     ?
      request.files.add(await http.MultipartFile.fromPath(
        'postVideo',
        pathvideo,
        contentType: new MediaType('video', 'mp4'),
      ));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      Get.snackbar('title', response.reasonPhrase.toString());
      print(response.reasonPhrase);
    }
    return response.reasonPhrase;
  }
}
