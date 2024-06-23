import 'package:wowondertimelineflutterapp/Util/AESEncryption/AES.dart';

class GetAllMesageModel {
  String text;
  String id;
  String avatar;
  String position;
  String time_text;
  String user_id;
  String media;
  String swowondertimelineflutterappers;
  String seen;
  String time;
  final replyText;
  final reaction;
  String reply_id;
  String page_id;
  GetAllMesageModel({
    required this.page_id,
    required this.seen,
    required this.time,
    required this.swowondertimelineflutterappers,
    required this.replyText,
    required this.reply_id,
    required this.text,
    required this.reaction,
    required this.user_id,
    required this.media,
    required this.time_text,
    required this.id,
    required this.avatar,
    required this.position,
  });

  factory GetAllMesageModel.fromJson(Map<String, dynamic> map) =>
      GetAllMesageModel(
        reaction: map['reaction'] == null ? '' : map['reaction'],
        seen: map['seen'] == null ? '' : map['seen'],
        time: map['time'] == null ? '' : map['time'],
        reply_id: map['reply_id'] == '0' ? '' : map['reply_id'],
        replyText: map['reply'] == null ? '' : map['reply'],
        time_text: map['time_text'] == null ? '' : map['time_text'],
        media: map['media'] == null ? '' : map['media'],
        swowondertimelineflutterappers: map['swowondertimelineflutterappers'] == null ? '' : map['swowondertimelineflutterappers'],
        id: map['id'] == null ? '' : map['id'],
        user_id: map['user_id'] == null ? '' : map['user_id'],
        position: map['position'] == null ? '' : map['position'],
        avatar: map['messageUser']['avatar'] == null
            ? ''
            : map['messageUser']['avatar'],
        text: map['text'] == null ? '' : decryptNewsOkl(map['text']),
        page_id: map['page_id'] == null ? '' : map['page_id'],
      );
}
