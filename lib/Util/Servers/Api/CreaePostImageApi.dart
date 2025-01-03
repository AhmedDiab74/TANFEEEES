import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wowondertimelineflutterapp/Screens/Home/ContHomeScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostImageApi {
  static Future cratepost({
    required pathimage,
    required pathvideo,
    required String text,
    required filename,
    required String postPrivacy,
    required String poll1,
    required String poll2,
    required String poll3,
    required String poll4,
    required String poll5,
    required String poll6,
    required String poll7,
    required String poll8,
    required String feeling_type,
    required pathpostPhotos,
    required group_id,
    required page_id,
    required String color,
    required postMap,
    required String postMapText,
    required travlin,
    required String travlintext,
    required gifs,
    required audioRecord,
  }) async {
    print(group_id.toString());
    print(page_id);
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    Map<String, String> hide = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };

                 final controller = Get.put(ContHomeScreen());
    
    var request = http.MultipartRequest(
        'POST', Uri.parse(accounts[0]['newposts'] + token));
    request.fields.addAll({
      accounts[0]['sm1']: accounts[0]['sm2'],
      'postText': text,
      'postPrivacy': postPrivacy,
      if (poll1.isNotEmpty) 'answer[0]': poll1,
      if (poll2.isNotEmpty) 'answer[1]': poll2,
      if (poll3.isNotEmpty) 'answer[2]': poll3,
      if (poll4.isNotEmpty) 'answer[3]': poll4,
      if (poll5.isNotEmpty) 'answer[4]': poll5,
      if (poll6.isNotEmpty) 'answer[5]': poll6,
      if (poll7.isNotEmpty) 'answer[6]': poll7,
      if (poll8.isNotEmpty) 'answer[7]': poll8,
      if (feeling_type.isNotEmpty) 'feeling_type': 'feelings',
      if (feeling_type.isNotEmpty) 'feeling': feeling_type,
      if (group_id != 'null') 'group_id': group_id,
      if (page_id != 'null') 'page_id': page_id,
      if (color.isNotEmpty) 'post_color': color,
      if (postMap != null) 'postMap': postMapText,
      if (travlin != null) 'feeling': travlintext,
      if (travlin.toString() == 'Traveling to') 'feeling_type': 'traveling',
      if (travlin.toString() == 'Watching') 'feeling_type': 'watching',
      if (travlin.toString() == 'Playing') 'feeling_type': 'playing',
      if (travlin.toString() == 'Listening to') 'feeling_type': 'listening',
      if (gifs != null) 'postType': 'postSticker',
      if (gifs != null) 'postSticker': gifs,
    });
    int _total = 0, _received = 0;
    request.headers.addAll(hide);
    if (await pathimage == null) {
      print('pathimage');
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        'postFile',
        pathimage,
      ));
    }
    if (await pathvideo == null) {
      null;
    } else {
      FFmpeg
          ? request.files.add(await http.MultipartFile.fromPath(
              'postVideo',
              pathvideo,
              filename: filename,
              contentType: new MediaType('video', 'mp4'),
            ))
          : request.files.add(await http.MultipartFile.fromPath(
              'postFile',
              pathvideo,
              filename: filename,
              contentType: new MediaType('video', 'mp4'),
            ));
    }

    if (pathpostPhotos.isNotEmpty)
      List.generate(pathpostPhotos.length, (index) async {
        request.files.add(await http.MultipartFile.fromPath(
            'postPhotos[]', pathpostPhotos[index].path));
      });

    if (audioRecord != null) if (!isAudio(audioRecord.toString())) {
      request.files.add(await http.MultipartFile.fromPath(
        'postFile',
        audioRecord,
      ));
    }
    if (audioRecord != null) if (isAudio(audioRecord.toString())) {
      print('aklsjdklasjdklsajkldj ${audioRecord}');
      print(audioRecord);
      request.files.add(await http.MultipartFile.fromPath(
        'postMusic',
        audioRecord,
      ));
    }
    final List<int> _bytes = [];
    http.StreamedResponse response = await request.send();

    _total = response.contentLength ?? 0;
    if (response.statusCode == 200) {

      response.stream.listen((value) {
        _bytes.addAll(value);
        _received += value.length;
   


        print('kaljsdljaslkdjaskld  ${_received ~/ 1024}/${_total ~/ 1024} KB');
      }).onDone(() async {
    print('kaljsdljaslkdjaskld  done');
      });
      print(await response.stream.bytesToString());
         controller.refesh();
    } else {
      Get.snackbar('title', response.reasonPhrase.toString());
      print(response.reasonPhrase);
      
    }
    return response.reasonPhrase;
  }
}
