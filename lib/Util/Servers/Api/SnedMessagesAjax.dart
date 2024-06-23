import 'dart:convert';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class SnedMessagesAjax {
  static Future send({
    required String user_id,
    required String gif,
    required String text,
    required filename,
    required file,
  }) async {
    print('jkasdhasjkdhajkshdjkashdkashjdks $file');
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['senms'] + await SharedP.Get('tok')));

    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'user_id': user_id,
      if (gif.isNotEmpty) 'gif': gif,
      if (text.isNotEmpty) 'text': text,
      'message_hash_id': 'ajslkdjksaljdklasjkdlj'
    });

    if (file.toString().isImageFileName)
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file,
      ));

    if (file.toString().isVideoFileName)
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file,
        filename: filename,
        contentType: new MediaType('video', 'mp4'),
      ));

    if (file.toString().isAudioFileName || file.toString().endsWith('m4a'))
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        file.replaceAll('file:///', ''),
        filename: filename,
        contentType: new MediaType('audio', 'wav'),
      ));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var news = await response.stream.bytesToString();
      var json = jsonDecode(news);
      print(json);
      return json;
    } else {
      print(response.reasonPhrase);
      return json;
    }
  }
}

// Future putData(data) async {
//   await box.clear();
//   for (var d in data) {
//     box.add(data);
//   }
// }

class ApiSendRecordAudio {
  static Future send(
    String use,
    String path,
    String filename,
    String sours,
  ) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['senms'] + await SharedP.Get('tok')));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      accounts[0]['use']: use,
      'message_hash_id': '44444444'
    });

    if (sours == 'audio')
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        path.replaceAll('file:///', ''),
        filename: filename,
        contentType: new MediaType('audio', 'wav'),
      ));
    if (sours == 'video')
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        path,
        filename: filename,
        contentType: new MediaType('video', 'mp4'),
      ));
    if (sours == 'image')
      request.files.add(await http.MultipartFile.fromPath(
        'file',
        path,
      ));
    // request.files.add(await http.MultipartFile.fromPath(
    //     'file', path.replaceAll('file://', '')));
    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var ameen = await response.stream.bytesToString();
      var file = jsonDecode(ameen);

      return file;
    } else {
      print(response.reasonPhrase);
    }
  }
}
