import 'package:wowondertimelineflutterapp/Util/AESEncryption/AES.dart';

class GetAllChatsModel {
  String user_id;
  String name;
  String avatar;
  String text;
  String time;
  String time_text;
  final count;
  String message_count;
  String username;
  String lastseen_status;
  String onwer;
  String lastseen_unix_time;
  final reaction;
  final chat_color;

  GetAllChatsModel({
    required this.reaction,
    required this.lastseen_status,
    required this.lastseen_unix_time,
    required this.count,
    required this.message_count,
    required this.time_text,
    required this.time,
    required this.text,
    required this.user_id,
    required this.username,
    required this.name,
    required this.onwer,
    required this.avatar,
    required this.chat_color,
  });

  factory GetAllChatsModel.fromJson(Map<String, dynamic> map) =>
      GetAllChatsModel(
        reaction: map['reaction'] == null ? '' : map['reaction'],
        message_count: map['message_count'] == null ? '' : map['message_count'],
        lastseen_status:
            map['lastseen_status'] == null ? '' : map['lastseen_status'],
        onwer:
            map['onwer'] == null ? '' : map['onwer'],
        lastseen_unix_time:
            map['lastseen_unix_time'] == null ? '' : map['lastseen_unix_time'],
        username: map['username'] == null ? '' : map['username'],
        count: map['last_message']['reaction'] == null
            ? ''
            : map['last_message']['reaction']['count'],
        time_text: map['last_message']['time_text'] == null
            ? ''
            : map['last_message']['time_text'],
        chat_color: map['last_message']['chat_color'] == null
            ? ''
            : map['last_message']['chat_color'],
        time: map['last_message']['time'] == null
            ? ''
            : map['last_message']['time'],
        text: map['last_message']['text'] == null
            ? ''
            : decryptNewsOkl( map['last_message']['text']),
        user_id: map['user_id'] == null ? '' : map['user_id'],
        name: map['name'] == null ? '' : map['name'],
        avatar: map['avatar'] == null ? '' : map['avatar'],
      );
}
