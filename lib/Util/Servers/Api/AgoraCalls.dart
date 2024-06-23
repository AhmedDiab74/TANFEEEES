import 'dart:convert';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/AnswerThecallScreen.dart';
// ApiAddWallet

class AgoraCallApi {
  static Future call() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('tok');
    if (token != null) {
      var url = Uri.parse(accounts[0]['getc'] + token);
      var response = await http.post(url, body: {
        accounts[0]['sm1']: accounts[0]['sm2'],
        'data_type': 'video_call'
      });

      var resp = response.body;

      var json = jsonDecode(resp);

      if (json['api_status'] == 200) {
        print(json);
        // print(
        //     'klajsdaskldjkalsjdklasjdklasjdasjdklasjdklasjdlkasjdklasjd ${json['video_call_user']['data']['id']}');

        if (json['video_call']) {
          Get.to(AnswerThecallScreen(
            call_type: 'video',
            id: json['video_call_user']['data']['id'],
            tokenAgro: json['video_call_user']['data']['access_token'],
            room_ch: json['video_call_user']['data']['room_name'],
            avat: json['video_call_user']['avatar'],
            name: json['video_call_user']['name'],
          ));
        } else if (json['audio_call']) {
          Get.to(AnswerThecallScreen(
            call_type: 'audio',
            id: json['agora_call_data']['data']['id'],
            tokenAgro: json['agora_call_data']['data']['access_token'],
            room_ch: json['agora_call_data']['data']['room_name'],
            avat: json['agora_call_data']['avatar'],
            name: json['agora_call_data']['name'],
          ));
        }

        //    Get.to(AnswerThecallScreen(
        //   id: await data['notification_data']['user_id'],
        //   tokenAgro: '',
        //   room_ch: '',
        //   call_type: '',
        //   avat: ameen['avatar'],
        //   name: ameen['name'],
        // ));
        return json;
      } else {
        return json;
      }
    }
  }
}
