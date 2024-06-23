import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCallsAgora.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/VideoCallScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class AnswerThecallScreen extends StatefulWidget {
  AnswerThecallScreen(
      {required this.id,
      required this.tokenAgro,
      required this.room_ch,
      required this.call_type,
      super.key,
      required this.avat,
      required this.name});
  String call_type;
  String tokenAgro;
  String room_ch;
  String id;
  final String avat;
  final String name;
  @override
  State<AnswerThecallScreen> createState() => _AnswerThecallScreenState();
}

class _AnswerThecallScreenState extends State<AnswerThecallScreen> {
  final player = AudioPlayer(); // Create a player
  void playSond() async {
    // ignore: unused_local_variable
    final duration = await player.setAsset('assets/images/ringtone-126505.mp3');
    await player.play();
  }

  bool callvido = false;
  @override
  void initState() {
    callvideo();
    SocketNew.socket.on('decline_call', (data) => {print(data)});
    playSond();
    // TODO: implement initState
    super.initState();
  }

  callvideo() {
    if (widget.call_type == 'audio') {
      setState(() {
        callvido = false;
        print('callllllllllll $callvido');
      });
    }
    if (widget.call_type == 'video') {
      setState(() {
        callvido = true;
        print('callllllllllll $callvido');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B2B2B),
      appBar: AppBar(
        title: Text('On Call'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorTheme,
        elevation: 0,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Container(
            decoration: BoxDecoration(
              color: ColorTheme,
              image: DecorationImage(
                image: Image.asset(
                  SvgImages.AudioCallPattern, // Replace with your image URL
                ).image,
                fit: BoxFit
                    .cover, // You can use different values depending on your needs
              ),
            ),
            height: Get.height,
            width: Get.width,
            child: Stack(children: [
              Positioned(
                bottom: Get.height * 0.1,
                left: Get.width * 0.1,
                right: Get.width * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        Get.back();
                        player.pause();
                        var ameen = await ApiAnswerCall.calls(
                            action: 'answer', call_id: widget.id);
                        print(
                            'klajsdaskldjkalsjdklasjdklasjdasjdklasjdklasjdlkasjdklasjd $ameen');
                        Get.to(CallVideoAgora(
                          myuserid: widget.id,
                          avat: widget.avat,
                          name: widget.name,
                          id: widget.id,
                          isBroadcaster: callvido,
                          channelName: widget.room_ch,
                          token: widget.tokenAgro,
                        ));
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        child: Icon(
                          size: 30,
                          callvido ? Icons.video_call : Icons.call,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.1,
                    ),
                    InkWell(
                      onTap: () async {
                        SocketNew.socket
                            .emit('decline_call', {'user_id': widget.id});
                        await player.pause();
                        Get.back();
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.call_end,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: Get.height * 0.19,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RippleAnimation(
                      child: CircleAvatar(
                        radius: 70,
                        child: CircleAvatar(
                            radius: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                widget.avat,
                                height: Get.height,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      color: ColorThemeDark,
                      delay: const Duration(milliseconds: 300),
                      repeat: true,
                      minRadius: 60,
                      ripplesCount: 6,
                      duration: const Duration(milliseconds: 6 * 300),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.name,
                        style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
