import 'dart:async';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/HomeScreenChat.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:agora_uikit/agora_uikit.dart';

class CallVideoAgora extends StatefulWidget {
  final String channelName;
  final bool isBroadcaster;
  final String token;
  final String avat;
  final String name;
  final String id;
  final String myuserid;

  const CallVideoAgora({
    required this.channelName,
    required this.isBroadcaster,
    required this.token,
    required this.avat,
    required this.name,
    required this.id,
    required this.myuserid,
  });

  @override
  _CallVideoAgoraState createState() => _CallVideoAgoraState();
}

class _CallVideoAgoraState extends State<CallVideoAgora> {
  void permission() async {
    await Permission.microphone;
    await Permission.camera;
  }

  int vewFullScreen = 0;
  final _users = <int>[];
  // RtcEngine? _engine;
  bool muted = false;
  int? streamId;
  bool speaker = false;
  String recordingTime = '0:0'; // to store value
  bool isRecording = false;
  bool timerStopCall = false;
  Timer? _timer;
  void recordTime() {
    var startTime = DateTime.now();
    Timer.periodic(const Duration(seconds: 0), (Timer t) {
      var diff = DateTime.now().difference(startTime);
      recordingTime =
          '${diff.inHours == 0 ? '' : diff.inHours.toString().padLeft(2, "0") + ':'}${(diff.inMinutes % 60).floor().toString().padLeft(2, "0")}:${(diff.inSeconds % 60).floor().toString().padLeft(2, '0')}';
      if (false) {
        t.cancel();
      }
      setState(() {});
    });
  }

  void timerEnd() {
    if (widget.isBroadcaster == false) {
      Timer.periodic(const Duration(seconds: 20), (Timer t) {
        if (timerStopCall) {
          // _onCallEnd(context);
          Get.back();
          Get.back();
          t.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    // clear users
    _users.clear();

    // destroy sdk and leave channel
    // _engine!.destroy();
    super.dispose();
  }

  @override
  void initState() {
    permission();
    timerEnd();
    clints();
    initAgora();

    super.initState();
    // initialize agora sdk
    // initializeAgora();
  }

  clints() {
    setState(() {
      client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: Agora_App_ID,
          channelName: 'stream_2_1884754',
          username: widget.channelName,
        ),
      );

      client.enabledPermission;
    });
  }

  late AgoraClient client;
  void initAgora() async {
    await client.initialize();
  }
  // Future<void> initializeAgora() async {
  //   await _initAgoraRtcEngine();
  //   if (widget.isBroadcaster)
  //     streamId = await _engine?.createDataStream(false, false);

  //   _engine!.setEventHandler(RtcEngineEventHandler(
  //     joinChannelSuccess: (channel, uid, elapsed) {
  //       setState(() {
  //         print('onJoinChannel: $channel, uid: $uid');
  //       });
  //     },
  //     leaveChannel: (stats) {
  //       setState(() {
  //         print('onLeaveChannel');
  //         _users.clear();
  //       });
  //     },
  //     userJoined: (uid, elapsed) {
  //       recordTime();
  //       setState(() {
  //         vewFullScreen = uid;
  //         print('userJoined: $uid');

  //         _users.add(uid);
  //       });
  //     },
  //     userOffline: (uid, elapsed) {
  //       setState(() {
  //         print('userOffline: $uid');
  //         _users.remove(uid);
  //         if (_users.length < 1) {
  //           _onCallEnd(context);
  //         }
  //       });
  //     },
  //     streamMessage: (_, __, message) {
  //       final String info = "here is the message $message";
  //       print(info);
  //     },
  //     streamMessageError: (_, __, error, ___, ____) {
  //       final String info = "here is the error $error";
  //       print(info);
  //     },
  //   ));

  //   await _engine!.joinChannel(widget.token, widget.channelName, null, 0);
  // }

  // Future<void> _initAgoraRtcEngine() async {
  //   _engine = await RtcEngine.createWithConfig(RtcEngineConfig(Agora_App_ID));

  //   await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
  //   if (widget.isBroadcaster) {
  //     await _engine!.enableVideo();
  //     await _engine!.setClientRole(ClientRole.Broadcaster);
  //   } else {
  //     await _engine!.disableVideo();
  //     await _engine!.setEnableSpeakerphone(speaker);
  //     await _engine!.setChannelProfile(ChannelProfile.Communication);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (true)
            AgoraVideoViewer(
              showNumberOfUsers: true,
              client: client,

              layoutType: Layout.oneToOne,
              enableHostControls: true, // Add this to enable host controls
            ),
          AgoraVideoButtons(
            client: client,
            addScreenSharing: false, // Add this to enable screen sharing
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      width: Get.width,
      height: Get.height * 0.12,
      decoration: BoxDecoration(
          color: ColorThemeDark,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          Container(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // RawMaterialButton(
                //   onPressed: _onToggleMute,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: const Color.fromARGB(113, 158, 158, 158),
                //         borderRadius: BorderRadius.circular(10)),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Icon(
                //         muted ? Icons.mic_off : Icons.mic,
                //         color: muted ? Colors.blue : Colors.white,
                //         size: 30.0,
                //       ),
                //     ),
                //   ),
                //   elevation: 2.0,
                // ),

                // RawMaterialButton(
                //   onPressed: _onSwitchCameraOrAudio,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: const Color.fromARGB(113, 158, 158, 158),
                //         borderRadius: BorderRadius.circular(10)),
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Icon(
                //         widget.isBroadcaster
                //             ? Icons.cameraswitch
                //             : speaker
                //                 ? Icons.volume_up
                //                 : Icons.volume_down_rounded,
                //         color: Colors.white,
                //         size: 30.0,
                //       ),
                //     ),
                //   ),
                //   elevation: 2.0,
                // ),

                // if (Group_Call_for_Pro_Users)
                //   RawMaterialButton(
                //     onPressed: () {
                //       Get.dialog(AddaPersonCall(
                //         myuserid: widget.myuserid,
                //         channelName: widget.channelName,
                //         id: widget.id,
                //         token: widget.token,
                //       ));
                //     },
                //     child: Icon(
                //       Icons.add,
                //       color: Colors.white,
                //       size: 35.0,
                //     ),
                //     elevation: 2.0,
                //   ),
              ],
            ),
          ),
        ],
      ),
    );

    // return
  }

  /// Helper function to get list of native views
  // List<Widget> _getRenderViews() {
  //   final List<StatefulWidget> list = [];
  //   if (widget.isBroadcaster) {
  //     list.add(RtcLocalView.SurfaceView());
  //   }
  //   _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(
  //         uid: uid,
  //         channelId: widget.channelName,
  //       )));
  //   return list;
  // }

  // /// Video view row wrapper
  // Widget _expandedVideoView(Widget views) {
  //   return Container(
  //     child: views,
  //   );
  // }

  // Widget _broadcastView(int videoNump) {
  //   final views = _getRenderViews();
  //   return _expandedVideoView(views[videoNump]);
  // }

  // void _onCallEnd(BuildContext context) {
  //   Navigator.pop(context);
  // }

  // void _onToggleMute() {
  //   setState(() {
  //     muted = !muted;
  //   });
  //   _engine!.muteLocalAudioStream(muted);
  // }

  // Future<void> _onSwitchCameraOrAudio() async {
  //   if (streamId != null)
  //     _engine?.sendStreamMessage(streamId!, Uint8List(streamId!));
  //   if (widget.isBroadcaster) _engine!.switchCamera();

  //   if (widget.isBroadcaster == false) {
  //     setState(() {
  //       speaker = !speaker;
  //     });

  //     _engine!.muteLocalAudioStream(muted);
  //     _engine!.setEnableSpeakerphone(speaker);
  //   }
  //   ;
  // }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3071375, size.height * 0.3273600);
    path_1.cubicTo(
        size.width * 0.3067750,
        size.height * 0.1999400,
        size.width * 0.3815000,
        size.height * 0.1964000,
        size.width * 0.4125000,
        size.height * 0.2000000);
    path_1.cubicTo(
        size.width * 0.4514375,
        size.height * 0.3614200,
        size.width * 0.5514000,
        size.height * 0.3594200,
        size.width * 0.5875000,
        size.height * 0.2000000);
    path_1.quadraticBezierTo(size.width * 0.6656000, size.height * 0.1954200,
        size.width * 0.6943500, size.height * 0.3273600);
    path_1.quadraticBezierTo(size.width * 0.6943500, size.height * 0.6060200,
        size.width * 0.6943500, size.height * 0.6990200);
    path_1.quadraticBezierTo(size.width * 0.6943500, size.height * 0.8229400,
        size.width * 0.6169000, size.height * 0.8229400);
    path_1.quadraticBezierTo(size.width * 0.4427250, size.height * 0.8229400,
        size.width * 0.3846250, size.height * 0.8229400);
    path_1.quadraticBezierTo(size.width * 0.3049125, size.height * 0.8229600,
        size.width * 0.3071375, size.height * 0.6990200);
    path_1.quadraticBezierTo(size.width * 0.3071375, size.height * 0.6060200,
        size.width * 0.3071375, size.height * 0.3273600);
    path_1.close();

    canvas.drawPath(path_1, paint_1);

    Paint paint_2 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5000002, size.height * 0.0804608);
    path_2.cubicTo(
        size.width * 0.5273750,
        size.height * 0.0804200,
        size.width * 0.5684875,
        size.height * 0.1111200,
        size.width * 0.5684620,
        size.height * 0.1899997);
    path_2.cubicTo(
        size.width * 0.5684875,
        size.height * 0.2338200,
        size.width * 0.5479250,
        size.height * 0.2995600,
        size.width * 0.5000002,
        size.height * 0.2995385);
    path_2.cubicTo(
        size.width * 0.4726125,
        size.height * 0.2995600,
        size.width * 0.4315250,
        size.height * 0.2667000,
        size.width * 0.4315384,
        size.height * 0.1899997);
    path_2.cubicTo(
        size.width * 0.4315250,
        size.height * 0.1462000,
        size.width * 0.4520625,
        size.height * 0.0804200,
        size.width * 0.5000002,
        size.height * 0.0804608);
    path_2.close();

    canvas.drawPath(path_2, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
