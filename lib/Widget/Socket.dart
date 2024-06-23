import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/AgoraCalls.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:flutter_io_socket/flutter_io_socket.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSendMessages.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSendRecordAudio.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSendMessageGroups.dart';

class SocketNew {
  static Socket socket = io(
      accounts[0]['nodejs'] + NodeJs_Port,
      OptionBuilder().setPath('/socket.io').setTransports(['websocket'])
          // .disableAutoConnect()
          // .setQuery({'hash': tokens, 'transport': 'websocket'})
          // .setExtraHeaders(
          //   {
          //     'sid': 'asasas',
          //     'connection': 'upgrades',
          //     'upgrades': 'websocket',
          //   },
          // )
          .build());

  static onncteSoket() async {
    final cont = await Get.put(GetMyUserDataCont());
    var token = await SharedP.Get('tok');

    await socket.connect();
    print(socket.query);

    socket.onConnectError((data) => print('connect Erorr: $data'));
    socket.onDisconnect((data) => print('soket io server disconcted'));
    for (var i = 0; i < cont.data.length; i++) print(cont.data[i].username);
    for (var i = 0; i < cont.data.length; i++)
      socket.emit("join", {
        "username": cont.data[i].username,
        "user_id": token,
        // "recipient_ids": [token],
        // "recipient_group_ids": [token],
      });
    // upadierUser();

    ////soken online
    socket.on('new_video_call', (data) async {
      print('klajsdas $data');
      AgoraCallApi.call();
    });

    SocketNew.socket.on('typing', (data) => {print('typing33 $data')});
    // socket.on('private_message', (data) {
    //   print('chatUser ${data}');
    // });
    // socket.on('private_message', (data) {
    //   print('private_message2 $data');
    // });

    // socket.emit('on_user_loggedin', {'from_id': token});
    // socket.on('on_user_loggedoff', (data) => print("on_user_loggedoff $data"));
    socket.on('color-change', (data) => print('color-change $data'));
    socket.on('on_user_loggedin', (data) => print("on_user_loggedin $data"));
    socket.on('group_message', (data) => print("group_message $data"));
    socket.on('page_message', (data) => print("page_message $data"));

    socket.on('new_notification', (data) => print("new_notification $data"));
    socket.on('typing_done', (data) => print("typing_done $data"));
    socket.on('user_notification', (data) => print("user_notification $data"));
    socket.on('create_video', (data) => print("create_video $data"));
    socket.on(
        'event_notification', (data) => print("event_notification $data"));

    socket.on('checkout_notification',
        (data) => print("checkout_notification $data"));
    socket.on('new_request', (data) => print("new_request $data"));
    socket.on('loadmore', (data) => print('loadmore:$data'));
    socket.on('join', (data) => print('joinsssswww$data'));
    // socket.on('ping_for_lastseen', (data) => print(data));
    socket.on('decline_call', (data) => print('decline_call: $data'));

    socket.on('seen_messages', (data) => print('seen_messages: $data'));
    socket.on('count_unseen_messages',
        (data) => print('count_unseen_messages: $data'));
    socket.on('lastseen',
        (data) => print('lastseen: $data')); //seen meesage مشاهدة الرسالة
    socket.on(
        'register_reaction',
        (data) => print(
            'register_reaction: $data')); //reaction messages تفاعل من الرسالة
    // socket.emit('main_notification', {
    //   'user_id': token,
    //   'to_id': '1',
    //   // 'type': 'removed',
    //   'type': 'added',
    // });
  }

  static sendmessageGroupsSoket(
    userid,
    username,
    text,
    isSwowondertimelineflutterapper,
    mediaId,
  ) async {
    var token = await SharedP.Get('tok');
    // onncteSoket('ameen');
    print(socket.id);

    // socket.on('event', (data) => rutern)
    socket.emit('group_message', {
      'to_id': userid,
      'from_id': token,
      'username': username,
      'msg': text,
      'color': '#f33d4c',
      // 'time': TimeOfDay.now().hour.minutes.toString(),
      'story_id': '',
      'isSwowondertimelineflutterapper': false,
      // 'isMedia': false,
      // 'isRecord': false,
      // 'message_reply_id': '0',
      'mediaId': '1',

      // 'time_api': TimeOfDay
    });
    var medid = await ApiSendMessageGroups.send(
        group_id: userid, gif: mediaId, text: text, mediaId: mediaId);
    if (mediaId.toString().isNotEmpty) {
      // Get.back();
    }
    print(medid);
  }

  static sendmessageSoket(
      {userid,
      username,
      text,
      isSwowondertimelineflutterapper,
      mediaId,
      replay,
      color,
      update}) async {
    print(replay);
    var token = await SharedP.Get('tok');
    // onncteSoket('ameen');
    print(socket.id);
    print('jkahsdjkhsajdhjshks ${'Sokek: $replay'}');
    // socket.on('event', (data) => rutern)
    socket.emit('private_message', {
      'to_id': userid,
      'from_id': token,
      'username': username,
      'msg': text,
      'color': color,
      'story_id': '',
      'isSwowondertimelineflutterapper': false,
      'mediaId': '1',
      if (replay.toString().isNotEmpty) 'message_reply_id': replay.toString(),
    });
    var medid = await ApiSendMessages.send(
      userid,
      mediaId,
      text,
      replay,
    );
    if (mediaId.toString().isNotEmpty) {
      // Get.back();
      // update();
    }
    print(medid);
  }

  static sendMessgaSoketMedia(
      {required userid,
      required path,
      required mediaName,
      required sours}) async {
    var senmess = await ApiSendRecordAudio.send(
        use: userid, path: path, filename: mediaName, sours: sours);
    print(senmess);
    var token = await SharedP.Get('tok');
    socket.emit('private_message', {
      'to_id': userid,
      'from_id': token,
      'mediaId': senmess['message_data'][0]['id'],
      // if(mediaName.toString().isNotEmpty) 'mediaFilename':mediaName,
    });
  }

  static UPDATEUSERLASTSEEN() async {
    var tok = await SharedP.Get('tok');
    socket.emit("ping_for_lastseen", {
      "user_id": tok,
    });
  }

  static LikeMessageSoc(id, raction) async {
    var token = await SharedP.Get('tok');
    socket.emit("register_reaction",
        {'type': 'messages', 'id': id, 'reaction': raction, 'user_id': token});
  }

  static sendtypingevet(userid) async {
    // var myuserid = SharedP.Get('user_id');
    var token = await SharedP.Get('tok');
    socket
        .emit(await "typing", {"recipient_id": userid, "user_id": await token});
  }

  static calssSokeit(
      {required id,
      required call_type,
      required room_name,
      required tokenagora,
      required callid,
      required myuserId}) async {
    var token = await SharedP.Get('tok');

    socket.emit('user_notification', {
      'user_id': token,
      'to_id': id,
      'call_type': call_type,
      'room_name': room_name,
      'token': tokenagora,
      'call_id': callid,
      'myuserid': myuserId,
      'type': 'create_video',
    });
  }
}
