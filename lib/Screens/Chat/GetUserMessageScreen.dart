import 'dart:io';
import 'dart:async';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:chewie/chewie.dart';
import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'dart:math' as math; // import this
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetAudio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/SendMessages.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/VideoListChat.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCallsAgora.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/Screens/AgoraCall/VideoCallScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserMessgesApi.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Screens/Privacy/PrivacySettingScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMesageModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMessageGroupsModel.dart';
import 'package:flutter_emoji_gif_picker/views/emoji_gif_picker_icon.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// ignore: must_be_immutable
class GetUserMessageScreen extends StatefulWidget {
  GetUserMessageScreen({
    required this.avat,
    required this.username,
    required this.name,
    required this.userid,
    super.key,
  });

  String userid;
  String name;
  String avat;
  String username;

  @override
  State<GetUserMessageScreen> createState() => _GetUserMessageScreenState();
}

class _GetUserMessageScreenState extends State<GetUserMessageScreen> {
  List<GetAllMesageModel> data = [];
  final player = AudioPlayer(); // Create a player
  bool palyAudio = false;
  String morId = '0';
  int typing = 300;
  void get() async {
    // }
    // ignore: unused_local_variable
    final ameen = await GetUserMessgesApi.chat(widget.userid, '').then((value) {
      setState(() {
        data = value.reversed.toList();
        morId = data[data.length - 1].id.toString();
      });

      SocketNew.socket.on(
          'typing',
          (data) => {
                setState(() {
                  typing = data['is_typing'];
                  print(typing);
                })
              });
      SocketNew.socket.emit('seen_messages', {
        "recipient_id": widget.userid,
        "user_id": getimydata.data[0].user_id.toString(),
        'message_id': data[data.length - 1].id.toString(),
        "current_user_id": widget.userid,
      });
    });
  }

  GetAgax() {
    if (NodeJS) {
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
        var ameen =
            await GetUserMessgesApi.chat(widget.userid, morId).then((value) {
          setState(() {
            // value.toList().isNotEmpty ? post = false : post = true;
            data.addAll(value.reversed.toList());
            morId = data[data.length - 1].id.toString();
          });
        });
        print(ameen);
      });
    }
  }

  TextEditingController _controllerSendMessages = TextEditingController();

  void sendComments() async {
    _sendMessg(_controllerSendMessages.text, '', '');
  }

////imagesUppld
  final ImagePicker picker = ImagePicker();
  XFile? ImagePost;

  Future<void> UplodeImage(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: send);
    print(picker);

    setState(() {
      ImagePost = image;
    });

    if (image != null) {
      Get.dialog(Scaffold(
        floatingActionButton: FloatingActionButton(
          hoverColor: Colors.orange,
          child: Icon(
            Icons.send,
            color: Colors.white,
          ),
          onPressed: () {
            if (NodeJS) {
              Get.back();
              Get.back();
              _sendMessgAudio(ImagePost!.path);
              SocketNew.sendMessgaSoketMedia(
                  userid: widget.userid,
                  path: ImagePost!.path,
                  mediaName: 'image',
                  sours: 'image');

              setState(() {
                if (ImagePost != null) {
                  ImagePost = null;
                }
              });

              get();
            } else {
              Get.back();
              Get.back();
              SendMessages.Send(
                  user_id: widget.userid,
                  gif: '',
                  text: '',
                  file: ImagePost!.path,
                  filename: filename);

              setState(() {
                ImagePost = null;
                filename = '';
              });
            }
          },
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Image.file(File(image!.path)),
        ),
      ));
    }
  }

  bool post = false;
  String text = '';
  String swowondertimelineflutterappersGif = '';

  void _sendMessg(text1, avatar, position) async {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        data.add(GetAllMesageModel(
            id: '',
            reaction: {"is_reacted": false, "type": "", "count": 0},
            reply_id: '',
            replyText: '',
            time_text: '',
            page_id: '',
            seen: '0',
            time: '0',
            media: '',
            text: _controllerSendMessages.text,
            avatar: getimydata.data[i].avatar,
            position: 'right',
            user_id: '',
            swowondertimelineflutterappers: ''));
      });

    print('text $text');

    setState(() {
      post = false;

      _controllerSendMessages.text = '';
    });
  }

  void _sendMessgAudio(audio) async {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        data.add(GetAllMesageModel(
            reaction: '',
            id: '',
            seen: '0',
            time: '0',
            reply_id: '',
            page_id: '',
            replyText: '',
            time_text: TimeOfDay.now().toString(),
            media: audio,
            text: '',
            avatar: getimydata.data[i].avatar,
            position: 'right',
            user_id: '',
            swowondertimelineflutterappers: ''));
      });

    print('text $text');

    setState(() {
      post = false;

      _controllerSendMessages.text = '';
    });
  }

  bool openEmoj = false;
  var keyboardVisibilityController = KeyboardVisibilityController();
  ScrollController _scrollController = ScrollController();

  scrollToCursor(String textFieldValue) async {
    final isLonger = textFieldValue.length > text.length;
    setState(() {
      text = textFieldValue;
    });
    print('ameen');

    if (isLonger)
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    audioRecord = Record();
    GetAgax();
    get();
    SocketNew.socket.on('private_message', (dat) {
      // data2.add(data3);
      // var ameno = jsonDecode(data3);

      // print('ameenjawad hamed22 ${dat}');
      // print('ameenjawad hamed ${data2[0]}');
      // print('ameenjawad hamed ${ameen}');
      get();
    });
    super.initState();
  }

  XFile? videoUp;
  String? filename;
  Future<void> vedioupolde(send) async {
    await Permission.storage.request();
    await Permission.photos.request();

    final XFile? video = await picker.pickVideo(source: send);

    setState(() {
      videoUp = video;
      filename = videoUp!.path.split('/').last;
    });

    if (video != null) {
      Get.dialog(Scaffold(
          floatingActionButton: FloatingActionButton(
            hoverColor: Colors.orange,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
              if (NodeJS) {
                _sendMessgAudio(videoUp!.path);
                SocketNew.sendMessgaSoketMedia(
                    userid: widget.userid,
                    path: videoUp!.path,
                    mediaName: filename,
                    sours: 'video');

                setState(() {
                  if (videoUp != null) {
                    videoUp = null;
                  }
                });
                get();
              } else {
                SendMessages.Send(
                    user_id: widget.userid,
                    gif: '',
                    text: '',
                    file: videoUp!.path,
                    filename: filename);

                setState(() {
                  ImagePost = null;
                  filename = '';
                });
              }
            },
          ),
          backgroundColor: Colors.black,
          body: VideoListChat(
            looping: true,
            videoPlayerController:
                VideoPlayerController.file(File(videoUp!.path)),
          )));
    }
  }

  TextEditingController _textController = TextEditingController();
  // ignore: must_call_super
  @override
  void dispose() {
    // get();
    // _controller.dispose();
    _scrollController.dispose();
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    _controllerSendMessages.dispose();
    audioRecord = Record();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);
    final Config = GetSetList[0];
    return Scaffold(
      backgroundColor: ColorTheme,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      Container(
                        height: Get.height * 0.10,
                        color: ColorTheme,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    )),
                                Row(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 20,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  widget.avat),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                height: 10,
                                                width: 10,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorTheme),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.01,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        Text(
                                          widget.name,
                                          style: SafeGoogleFont(Fonts.font3,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : Colors.white),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              typing == 200
                                                  ? 'Typing...'
                                                  : 'Active Now',
                                              style: SafeGoogleFont(Fonts.font1,
                                                  fontSize: 12,
                                                  color: Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.white),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(children: [
                              if (Config['audio_chat'] == '1')
                                Material(
                                  color: Colors.transparent,
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(50),
                                  child: InkWell(
                                      onTap: () async {
                                        var calls = await ApiCallsAgora.calls(
                                            widget.userid, 'audio');
                                        SocketNew.calssSokeit(
                                          call_type: 'audio',
                                          callid: calls['id'],
                                          id: widget.userid,
                                          myuserId: widget.userid,
                                          room_name: calls['room_name'],
                                          tokenagora: calls['token'],
                                        );
                                        Get.to(CallVideoAgora(
                                          isBroadcaster: false,
                                          channelName: calls['room_name'],
                                          token: calls['token'],
                                          avat: widget.avat,
                                          name: widget.name,
                                          id: widget.userid,
                                          myuserid: widget.userid,
                                        ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: SvgPicture.asset(
                                            SvgImages.AudioCall,
                                            width: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              if (Config['video_chat'] == '1')
                                Material(
                                  color: Colors.transparent,
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(50),
                                  child: InkWell(
                                      onTap: () async {
                                        var calls = await ApiCallsAgora.calls(
                                            widget.userid, 'video');
                                        SocketNew.calssSokeit(
                                          call_type: 'video',
                                          callid: calls['id'],
                                          id: widget.userid,
                                          myuserId: widget.userid,
                                          room_name: calls['room_name'],
                                          tokenagora: calls['token'],
                                        );
                                        Get.to(CallVideoAgora(
                                          myuserid: widget.userid,
                                          isBroadcaster: true,
                                          channelName: calls['room_name'],
                                          token: calls['token'],
                                          avat: widget.avat,
                                          name: widget.name,
                                          id: '',
                                        ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          SvgImages.VideoCall,
                                          width: 25,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              SizedBox(
                                width: Get.width * 0.05,
                              )

                              // IconButton(
                              //   onPressed: () {},
                              //   icon: Icon(
                              //     Icons.info,
                              //     color: Colors.white,
                              //   ),
                              // ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  top: Get.height * 0.14,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            width: Get.width,
                            child: SingleChildScrollView(
                              reverse: true,
                              child: Column(
                                children: [
                                  for (var i = 0; i < data.length; i++)
                                    Column(
                                      children: [
                                        if (data[i].position == 'left')
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1, vertical: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: Get.width * 0.01,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  // width: Get.width * 0.60,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: data[i]
                                                                      .text
                                                                      .length >
                                                                  80
                                                              ? Get.width * 0.66
                                                              : null,
                                                          child: Text(
                                                            data[i]
                                                                .text
                                                                .replaceAll(
                                                                    '<br>',
                                                                    '\n')
                                                                .replaceAll(
                                                                    '&#039;',
                                                                    '\''),
                                                            style: SafeGoogleFont(
                                                                Fonts.font1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        if (data[i]
                                                            .media
                                                            .isImageFileName)
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  data[i].media,
                                                              fit: BoxFit.cover,
                                                              width: Get.width *
                                                                  0.40,
                                                            ),
                                                          ),
                                                        if (data[i]
                                                            .media
                                                            .isAudioFileName)
                                                          WidgetSond(
                                                              postRecord:
                                                                  data[i]
                                                                      .media),
                                                        if (data[i]
                                                            .media
                                                            .isVideoFileName)
                                                          Container(
                                                            width: Get.width *
                                                                0.50,
                                                            height: Get.height *
                                                                0.30,
                                                            child:
                                                                VideoListChat2(
                                                              video:
                                                                  data[i].media,
                                                              looping: false,
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.01,
                                                ),
                                                InkWell(
                                                  child: SvgPicture.asset(
                                                      'assets/svg/chat/swowondertimelineflutterapper-smile-circle-svgrepo-com.svg'),
                                                )
                                              ],
                                            ),
                                          ),

                                        //left
                                        if (data[i].position == 'right')
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 1, vertical: 2),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Get
                                                                      .isDarkMode
                                                                  ? Color
                                                                      .fromARGB(
                                                                          44,
                                                                          210,
                                                                          202,
                                                                          202)
                                                                  : Color(
                                                                      0xff5DB5A6),
                                                              // borderRadius:
                                                              //     BorderRadius.circular(30),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                            ),
                                                            // width: Get.width * 0.30,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          10),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: data[i].text.length >
                                                                            80
                                                                        ? Get.width *
                                                                            0.66
                                                                        : null,
                                                                    child: Text(
                                                                      data[i]
                                                                          .text
                                                                          .replaceAll(
                                                                              '<br>',
                                                                              '\n')
                                                                          .replaceAll(
                                                                              '&#039;',
                                                                              '\''),
                                                                      style:
                                                                          SafeGoogleFont(
                                                                        Fonts
                                                                            .font1,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (data[i]
                                                                      .media
                                                                      .isImageFileName)
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      child:
                                                                          CachedNetworkImage(
                                                                        imageUrl:
                                                                            data[i].media,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        width: Get.width *
                                                                            0.40,
                                                                      ),
                                                                    ),
                                                                  if (data[i]
                                                                      .media
                                                                      .isAudioFileName)
                                                                    WidgetSond(
                                                                        postRecord:
                                                                            data[i].media),
                                                                  if (data[i]
                                                                      .media
                                                                      .isVideoFileName)
                                                                    Container(
                                                                      width: Get
                                                                              .width *
                                                                          0.50,
                                                                      height: Get
                                                                              .height *
                                                                          0.30,
                                                                      child:
                                                                          VideoListChat2(
                                                                        video: data[i]
                                                                            .media,
                                                                        looping:
                                                                            false,
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                      // CircleAvatar(
                                                      //   backgroundImage: CachedNetworkImageProvider(
                                                      //       data[i].avatar),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///Send Messages

                        Expanded(
                          flex: 0,
                          child: Container(
                            height: Get.height * 0.1,
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Color.fromARGB(44, 210, 202, 202)
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            width: Get.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(Container(
                                        height: Get.height * 0.10,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                        ),
                                        child: Row(children: [
                                          InkWell(
                                            onTap: () {
                                              UplodeImage(ImageSource.gallery);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundColor: ColorTheme,
                                                child: Icon(
                                                  Icons.photo,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              UplodeImage(ImageSource.camera);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundColor: ColorTheme,
                                                child: Icon(
                                                  Icons.camera,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              vedioupolde(ImageSource.gallery);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundColor: ColorTheme,
                                                child: Icon(
                                                  Icons.photo_camera_back,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              vedioupolde(ImageSource.camera);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundColor: ColorTheme,
                                                child: Icon(
                                                  Icons.video_camera_back,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ));

                                      // record
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color:
                                            Color.fromARGB(255, 195, 231, 223),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Icon(
                                          Icons.add,
                                          color: Color(0xff00B88F),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Color.fromARGB(44, 210, 202, 202)
                                            : Color(0xffF2F0EB),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: Get.width * 0.70,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Get.width * 0.45,
                                          child: TextField(
                                            maxLines: null,
                                            maxLength: null,
                                            onChanged: (value) async {
                                              var token =
                                                  await SharedP.Get('tok');
                                              scrollToCursor(value);
                                              SocketNew.sendtypingevet(
                                                  widget.userid);
                                            },
                                            controller: _controllerSendMessages,
                                            decoration: InputDecoration(
                                                hintText: 'Type Message...'.tr,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        if (NodeJS)
                                          if (audioPath != null)
                                            InkWell(
                                                onTap: () async {
                                                  _sendMessgAudio(audioPath);
                                                  SocketNew
                                                      .sendMessgaSoketMedia(
                                                          userid: widget.userid,
                                                          path: audioPath,
                                                          mediaName: filename,
                                                          sours: 'audio');

                                                  final path =
                                                      await _audioRecorder
                                                          .stop();
                                                  setState(() {
                                                    if (path != null) {
                                                      audioPath = null;
                                                      path != null;
                                                    }
                                                  });
                                                },
                                                child: Icon(Icons.send)),
                                        if (NodeJS == false)
                                          if (audioPath == null)
                                            InkWell(
                                                onTap: () async {
                                                  SendMessages.Send(
                                                      user_id: widget.userid,
                                                      gif: '',
                                                      text: text,
                                                      file: '',
                                                      filename: '');

                                                  setState(() {
                                                    _recordDuration = 0;
                                                    videoUp = null;
                                                    ImagePost = null;
                                                    filename = '';
                                                    text = '';
                                                    _controllerSendMessages
                                                        .clear();
                                                  });
                                                },
                                                child: SvgPicture.asset(
                                                    SvgImages.AddPerson))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  _controllerSendMessages.text.isEmpty
                                      ? showPlayer
                                          ? Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      showPlayer = true;
                                                      _recordDuration = 0;
                                                      videoUp = null;
                                                      ImagePost = null;
                                                      filename = '';
                                                      text = '';
                                                      palyAudio = false;
                                                      audioPath = '';
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    if (palyAudio) {
                                                      player.stop();
                                                      setState(() {
                                                        palyAudio = false;
                                                      });
                                                    } else {
                                                      await player.setFilePath(
                                                          audioPath.toString());

                                                      player.play();
                                                      setState(() {
                                                        palyAudio = true;
                                                      });
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Color(0xffFB784E),
                                                    child: Icon(
                                                      palyAudio
                                                          ? Icons.stop
                                                          : Icons.play_arrow,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      if (text.isNotEmpty)
                                                        sendComments();
                                                      for (var i = 0;
                                                          i <
                                                              getimydata
                                                                  .data.length;
                                                          i++)
                                                        SocketNew
                                                            .sendmessageSoket(
                                                                userid: widget
                                                                    .userid,
                                                                username:
                                                                    getimydata
                                                                        .data[i]
                                                                        .username,
                                                                text: text,
                                                                isSwowondertimelineflutterapper:
                                                                    false,
                                                                mediaId: '',
                                                                replay: '');

                                                      setState(() {
                                                        text = '';
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Get.isDarkMode
                                                            ? Color.fromARGB(44,
                                                                210, 202, 202)
                                                            : ColorTheme,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(Icons.send,
                                                          size: 20,
                                                          color: Get.isDarkMode
                                                              ? Colors.white
                                                              : Colors.white),
                                                    )),
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: isRecoridng
                                                      ? stopRecording
                                                      : startRecording,
                                                  child: SvgPicture.asset(
                                                    SvgImages.Microphone,
                                                    color: Color(0xffFB784E),
                                                    width: Get.width * 0.08,
                                                  ),
                                                ),
                                                if (_recordDuration > 0)
                                                  Text(_recordDuration
                                                      .toString())
                                              ],
                                            )
                                      : InkWell(
                                          onTap: () {
                                            if (text.isNotEmpty) sendComments();
                                            for (var i = 0;
                                                i < getimydata.data.length;
                                                i++)
                                              SocketNew.sendmessageSoket(
                                                  userid: widget.userid,
                                                  username: getimydata
                                                      .data[i].username,
                                                  text: text,
                                                  isSwowondertimelineflutterapper: false,
                                                  mediaId: '',
                                                  replay: '');

                                            setState(() {
                                              text = '';
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? Color.fromARGB(
                                                      44, 210, 202, 202)
                                                  : ColorTheme,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: EdgeInsets.all(10),
                                            child: Icon(Icons.send,
                                                size: 20,
                                                color: Get.isDarkMode
                                                    ? Colors.white
                                                    : Colors.white),
                                          )),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget _widgetSend({required Widget Record}) {
  //   return
  // }

  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = Record();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  bool showPlayer = false;
  String? audioPath;
  XFile? mediapath;
  bool isRecoridng = false;
  late Record audioRecord;
  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        print(await audioRecord.isEncoderSupported(
          AudioEncoder.wav,
        ));
        await audioRecord.start(
          path: audioPath,
          encoder: AudioEncoder.wav, // by default
          bitRate: 128000, // by default
        );

        setState(() {
          isRecoridng = true;
          _startTimer();
        });
      }
    } catch (e) {
      print('Erorr start Recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecoridng = false;
        audioPath = path;
        mediapath != audioPath;
        print(mediapath);

        File file = new File(path!);
        filename = path.split('/').last;
        print(filename);
        showPlayer = true;
        _timer!.cancel();
      });

      print('klajsdlkjaskldjaskldjask $filename');
      print('klajsdlkjaskldjaskldjask $audioPath');
    } catch (e) {
      print('Erorr stoping Recording : $e');
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();

    final path = await _audioRecorder.stop();

    if (kDebugMode)
      setState(() {
        audioPath = path;
        mediapath != audioPath;
        File file = new File(path!);
        filename = path.split('/').last;
        print(filename);
        showPlayer = true;
      });

    setState(() {
      isRecoridng = false;
    });
  }

  Future<void> _pause() async {
    _timer?.cancel();
    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();
    await _audioRecorder.resume();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() => _recordDuration++);
    });
  }

  Future<void> _start() async {
    await Permission.microphone.request();
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await _audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );

        print('${AudioEncoder.wav.name} supported: $isSupported');
        final devs = await _audioRecorder.listInputDevices();
        final isRecording = await _audioRecorder.isRecording();

        _recordDuration = 0;

        _startTimer();
        setState(() {
          isRecoridng = true;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }

    return numberStr;
  }
}

class FetchReactionMessages extends StatelessWidget {
  const FetchReactionMessages({
    super.key,
    required this.data,
  });

  final data;
//  static String Like = pathReactions + 'like.png';
//   static String Love = pathReactions + 'love.png';
//   static String Haha = pathReactions + 'haha.png';
//   static String Wow = pathReactions + 'wow.png';
//   static String Sad = pathReactions + 'sad.png';
//   static String Angry = pathReactions + 'angry.png';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (data['1'] != null)
          Image.asset(
            images.Like,
            height: Get.height * 0.025,
          ),
        if (data['2'] != null)
          Image.asset(
            images.Love,
            height: Get.height * 0.025,
          ),
        if (data['3'] != null)
          Image.asset(
            images.Haha,
            height: Get.height * 0.025,
          ),
        if (data['4'] != null)
          Image.asset(
            images.Wow,
            height: Get.height * 0.025,
          ),
        if (data['5'] != null)
          Image.asset(
            images.Sad,
            height: Get.height * 0.025,
          ),
        if (data['6'] != null)
          Image.asset(
            images.Angry,
            height: Get.height * 0.025,
          ),
      ],
    );
  }
}

// import 'dart:async';
// import 'dart:io';

// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:chat_bubbles/chat_bubbles.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_emoji_gif_picker/flutter_emoji_gif_picker.dart';

// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:permission_handler/permission_handler.dart';

// import 'package:record/record.dart';
// import 'package:wowondertimelineflutterapp/Screens/AgoraCall/VideoCallScreen.dart';
// import 'package:wowondertimelineflutterapp/Screens/Chat/PlayRecrodSondChat.dart';
// import 'package:wowondertimelineflutterapp/Screens/Chat/VideoListChat.dart';
// import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
// import 'package:wowondertimelineflutterapp/Themes.dart';
// import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiCallsAgora.dart';
// import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserMessgesApi.dart';
// import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMesageModel.dart';
// import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
// import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
// import 'package:wowondertimelineflutterapp/main.dart';

// class GetUserMessageScreen extends StatefulWidget {
//   GetUserMessageScreen(
//       {required this.avat,
//       required this.username,
//       required this.name,
//       required this.userid,
//       super.key});
//   String userid;
//   String name;
//   String avat;
//   String username;
//   @override
//   State<GetUserMessageScreen> createState() => _GetUserMessageScreenState();
// }

// class _GetUserMessageScreenState extends State<GetUserMessageScreen> {
//   final getimydata = Get.put(GetMyUserDataCont());

//   List<GetAllMesageModel> data = [];
//   void get() async {
//     // }
//     final ameen = GetUserMessgesApi.chat(widget.userid).then((value) {
//       setState(() {
//         // value.toList().isNotEmpty ? post = false : post = true;
//         data = value.reversed.toList();
//       });
//       SocketNew.socket.emit('seen_messages', {
//         "recipient_id": widget.userid,
//         "user_id": getimydata.data[0].user_id.toString(),
//         'message_id': data[data.length - 1].id.toString(),
//         "current_user_id": widget.userid,
//       });
//     });
//   }

//   late StreamSubscription<bool> keyboardSubscription;
//   String text = '';

//   @override
//   void initState() {
//     get();
//     witters();

//     openKeypord();
//     showPlayer = false;
//     socketGet();

//     ///
//     SocketNew.socket.on('private_message', (data) {
//       get();
//     });

//     ///
//     _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
//       setState(() => _recordState = recordState);
//     });

//     _amplitudeSub = _audioRecorder
//         .onAmplitudeChanged(const Duration(milliseconds: 300))
//         .listen((amp) => setState(() => _amplitude = amp));

//     ///
//     ///
//     ///
//     super.initState();
//   }

//   // socketGetsMess() {
//   //   Timer.periodic(Duration(seconds: 1), (timer) {

//   //   });
//   // }

//   socketGet() {
//     SocketNew.socket.on('lastseen', (ww) {
//       print(data);
//       get();
//       print(data[data.length - 1].id.toString());
//     });
//     SocketNew.socket.on('register_reaction', (ww) {
//       get();
//     });
//   }

//   bool openKey = false;
//   bool post = false;
//   TextEditingController textfiled = TextEditingController();
//   void sendComments() async {
//     _sendMessg(textfiled.text, '', '');
//   }

//   String swowondertimelineflutterappersGif = '';
//   void _sendMessg(text1, avatar, position) async {
//     for (var i = 0; i < getimydata.data.length; i++)
//       setState(() {
//         data.add(GetAllMesageModel(
//             id: '',
//             reaction: {"is_reacted": false, "type": "", "count": 0},
//             reply_id: '',
//             replyText: '',
//             time_text: '',
//             seen: '0',
//             media: '',
//             text: textfiled.text,
//             avatar: getimydata.data[i].avatar,
//             position: 'right',
//             user_id: '',
//             swowondertimelineflutterappers: ''));
//       });

//     print('text $text');

//     setState(() {
//       post = false;

//       textfiled.text = '';
//     });
//   }

//   void _sendMessgAudio(audio) async {
//     for (var i = 0; i < getimydata.data.length; i++)
//       setState(() {
//         data.add(GetAllMesageModel(
//             reaction: '',
//             id: '',
//             seen: '0',
//             reply_id: '',
//             replyText: '',
//             time_text: TimeOfDay.now().toString(),
//             media: audio,
//             text: '',
//             avatar: getimydata.data[i].avatar,
//             position: 'right',
//             user_id: '',
//             swowondertimelineflutterappers: ''));
//       });

//     print('text $text');

//     setState(() {
//       post = false;

//       textfiled.text = '';
//     });
//   }

//   bool openEmoj = false;
//   var keyboardVisibilityController = KeyboardVisibilityController();
//   ScrollController _scrollController = ScrollController();
//   scrollToCursor(String textFieldValue) async {
//     final isLonger = textFieldValue.length > text.length;
//     setState(() {
//       text = textFieldValue;
//     });
//     print('ameen');

//     if (isLonger)
//       _scrollController.animateTo(_scrollController.position.maxScrollExtent,
//           duration: Duration(milliseconds: 300), curve: Curves.ease);
//   }

//   void openKeypord() {
//     keyboardSubscription =
//         keyboardVisibilityController.onChange.listen((bool visible) {
//       setState(() {
//         openKey = visible;
//         print(openKey);
//       });
//     });
//   }

//   final TextEditingController _controller = TextEditingController();
//   bool emojiShowing = false;

//   @override
//   void dispose() {
//     _controller.dispose();
//     _scrollController.dispose();
//     _timer?.cancel();
//     _recordSub?.cancel();
//     _amplitudeSub?.cancel();
//     _audioRecorder.dispose();
//     super.dispose();
//   }

//   bool witter = false;
//   void witters() {
//     SocketNew.socket.on(
//         'typing',
//         (data) => {
//               if (data['is_typing'] == 200)
//                 {
//                   setState(() {
//                     witter = true;
//                   })
//                 }
//               else if (data['is_typing'] == 300)
//                 {
//                   setState(() {
//                     witter = true;
//                   })
//                 }
//             });
//   }

//   // Future record() async {
//   //   if (await recordd.hasPermission()) {
//   //     // Start recording
//   //     await recordd.start(
//   //       path: 'aFullPath/myFile.m4a',
//   //       encoder: AudioEncoder.aacLc, // by default
//   //       bitRate: 128000, // by default
//   //       samplingRate: 44100, // by default
//   //     );
//   //   }
//   // }

//   int _recordDuration = 0;
//   Timer? _timer;
//   final _audioRecorder = Record();
//   StreamSubscription<RecordState>? _recordSub;
//   RecordState _recordState = RecordState.stop;
//   StreamSubscription<Amplitude>? _amplitudeSub;
//   Amplitude? _amplitude;
//   String _filename = '';
//   bool showPlayer = false;
//   String? audioPath;
//   XFile? mediapath;
//   Future<void> _stop() async {
//     _timer?.cancel();

//     _recordDuration = 0;

//     final path = await _audioRecorder.stop();

//     if (kDebugMode)
//       setState(() {
//         audioPath = path;
//         mediapath != audioPath;
//         File file = new File(path!);
//         _filename = path.split('/').last;
//         print(_filename);
//         showPlayer = true;
//       });
//   }

//   Future<void> _pause() async {
//     _timer?.cancel();
//     await _audioRecorder.pause();
//   }

//   Future<void> _resume() async {
//     _startTimer();
//     await _audioRecorder.resume();
//   }

//   void _startTimer() {
//     _timer?.cancel();

//     _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//       setState(() => _recordDuration++);
//     });
//   }

//   Future<void> _start() async {
//     await Permission.microphone.request();
//     try {
//       if (await _audioRecorder.hasPermission()) {
//         // We don't do anything with this but printing
//         final isSupported = await _audioRecorder.isEncoderSupported(
//           AudioEncoder.wav,
//         );
//         if (kDebugMode) {
//           print('${AudioEncoder.wav.name} supported: $isSupported');
//         }

//         // final devs = await _audioRecorder.listInputDevices();
//         // final isRecording = await _audioRecorder.isRecording();

//         await _audioRecorder.start();
//         _recordDuration = 0;

//         _startTimer();
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   String _formatNumber(int number) {
//     String numberStr = number.toString();
//     if (number < 10) {
//       numberStr = '0$numberStr';
//     }

//     return numberStr;
//   }

// ////imagesUppld
//   ///
//   XFile? ImagePost;
//   Future<void> UplodeImage(send) async {
//     await Permission.storage.request();
//     await Permission.photos.request();
//     final XFile? image = await picker.pickImage(source: send);
//     print(picker);

//     Get.back();
//     setState(() {
//       ImagePost = image;
//     });
//   }

//   final ImagePicker picker = ImagePicker();
//   List<XFile> imageFileList = [];
//   void selectimges() async {
//     final List<XFile>? selectedImages = await picker.pickMultiImage();
//     if (selectedImages!.isNotEmpty) {
//       setState(() {
//         imageFileList.addAll(selectedImages);
//       });
//       ;
//     }
//     print('images List Lenth' + imageFileList.length.toString());
//   }

//   XFile? videoUp;
//   String? filename;
//   Future<void> vedioupolde(send) async {
//     await Permission.storage.request();
//     await Permission.photos.request();

//     final XFile? video = await picker.pickVideo(source: send);

//     setState(() {
//       videoUp = video;
//       filename = videoUp!.path.split('/').last;
//     });

//     _sendMessgAudio(videoUp!.path);
//     SocketNew.sendMessgaSoketMedia(
//         widget.userid, videoUp!.path, filename, 'video');

//     Get.back();
//   }

//   ///
//   ///
//   ///
//   ///
// ////
// //رؤوية الرسالة

//   ///
//   Widget build(BuildContext context) {
//     final String minutes = _formatNumber(_recordDuration ~/ 60);
//     final String seconds = _formatNumber(_recordDuration % 60);
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: Scaffold(
//         floatingActionButton: ////done
//             Container(
//           height: Get.height * 0.1,
//           color: Get.isDarkMode
//               ? colorBackRoundCommentsDark
//               : colorBackRoundCommentsLighet,
//           child: Column(
//             children: [
//               Container(
//                 width: Get.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     if (audioPath != null)
//                       InkWell(
//                         onTap: () async {
//                           final path = await _audioRecorder.stop();
//                           setState(() {
//                             if (path != null) {
//                               audioPath = null;
//                               path != null;
//                             }
//                           });
//                         },
//                         child: CircleAvatar(
//                             backgroundColor:
//                                 Get.isDarkMode ? Colors.blue : Colors.white,
//                             child: Icon(
//                               Icons.delete,
//                               color:
//                                   Get.isDarkMode ? Colors.white : Colors.black,
//                             )),
//                       ),
//                     if (audioPath == null)
//                       SvgPicture.asset('assets/images/svg/PathGif.svg'),
//                     SizedBox(
//                       width: Get.width * 0.01,
//                     ),
//                     if (audioPath != null)
//                       PlayRecrodSondChat(
//                         postRecord: audioPath!,
//                       ),
//                     if (audioPath == null)
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: Get.isDarkMode
//                                   ? Color.fromARGB(255, 54, 54, 54)
//                                   : Color(0xffE9F0FB)),
//                           height: text.length > 100 ? Get.height * 0.1 : null,
//                           child: Row(
//                             children: [
//                               EmojiGifPickerIcon(
//                                 id: "1",
//                                 onGifSelected: (gif) async {
//                                   sendComments();
//                                   print(gif!.images!.fixedWidth!.url);
//                                   for (var i = 0;
//                                       i < getimydata.data.length;
//                                       i++)
//                                     SocketNew.sendmessageSoket(
//                                         widget.userid,
//                                         getimydata.data[i].username,
//                                         '',
//                                         true,
//                                         gif.images!.fixedWidth!.url);

//                                   setState(() {
//                                     data.add(GetAllMesageModel(
//                                         seen: '0',
//                                         reaction: '',
//                                         replyText: '',
//                                         media: '',
//                                         reply_id: '',
//                                         time_text: '',
//                                         id: '',
//                                         text: '',
//                                         avatar: '',
//                                         position: 'right',
//                                         user_id: '',
//                                         swowondertimelineflutterappers: gif.images!.fixedWidth!.url
//                                             .toString()));
//                                   });

//                                   print(data[data.length - 1].id);
//                                   EmojiGifPickerPanel.close();
//                                   setState(() {
//                                     text = '';
//                                   });
//                                 },
//                                 fromStack: false,
//                                 controller: textfiled,
//                                 viewEmoji: false,
//                                 viewGif: true,
//                                 icon: const Icon(Icons.emoji_emotions),
//                               ),
//                               // if (audioFile.isNotEmpty)
//                               //   RecrodWidget(
//                               //     postRecord: audioFile,
//                               //   ),
//                               // if (audioFile.isEmpty)
//                               Container(
//                                 width: Get.width * 0.40,
//                                 child: TextField(
//                                   onSubmitted: (value) {
//                                     sendComments();
//                                   },
//                                   controller: textfiled,
//                                   onChanged: (value) async {
//                                     var token = await SharedP.Get('tok');
//                                     scrollToCursor(value);
//                                     SocketNew.sendtypingevet(widget.userid);
//                                   },
//                                   scrollController: _scrollController,
//                                   maxLines: null,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                         borderSide: BorderSide.none),
//                                     filled: true,
//                                     hintText: 'Start Typing…'.tr,
//                                     fillColor: Get.isDarkMode
//                                         ? Color.fromARGB(255, 54, 54, 54)
//                                         : Color(0xffE9F0FB),
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   Get.bottomSheet(WidgetPhotoAnvideo(''));
//                                 },
//                                 child: SvgPicture.asset(
//                                     'assets/images/svg/Group 5.svg'),
//                               ),
//                               SizedBox(
//                                 width: Get.width * 0.01,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                     Column(
//                       children: [
//                         Container(child: _buildRecordStopControl()),
//                         if (seconds != '00')
//                           Text(
//                             '$minutes : $seconds',
//                           ),
//                       ],
//                     ),
//                     SizedBox(
//                       width: Get.width * 0.01,
//                     ),
//                     // InkWell(
//                     //   onTap: () async {
//                     //     if (recordd.has) {
//                     //       await stop();
//                     //       print(audioFile.toString());
//                     //     } else {
//                     //       await record();
//                     //     }
//                     //     setState(() {});
//                     //   },
//                     //   child: Column(
//                     //     children: [
//                     //       StreamBuilder<RecordingDisposition>(
//                     //         builder: ((context, snapshot) {
//                     //           final duration = snapshot.hasData
//                     //               ? snapshot.data!.duration
//                     //               : Duration.zero;
//                     //           String twoDigits(int n) =>
//                     //               n.toString().padLeft(2, '0');
//                     //           String twoDigitMinutes = twoDigits(
//                     //               duration.inMinutes.remainder(60));
//                     //           final towDigitSeconds = twoDigits(
//                     //               duration.inSeconds.remainder(60));
//                     //           return Text(
//                     //               '$twoDigitMinutes:$towDigitSeconds');
//                     //         }),
//                     //         stream: recorder.onProgress,
//                     //       ),
//                     //       recorder.isRecording
//                     //           ? Icon(Icons.stop)
//                     //           : Container(
//                     //               child: Padding(
//                     //                 padding: const EdgeInsets.all(2.0),
//                     //                 child: SvgPicture.asset(
//                     //                     'assets/images/svg/Group 4 Copy 2.svg'),
//                     //               ),
//                     //             ),
//                     //     ],
//                     //   ),
//                     // ),
//                     if (ImagePost == null)
//                       if (audioPath == null)
//                         text.length < 1
//                             ? SvgPicture.asset(
//                                 'assets/images/svg/Combined 4.svg')
//                             : InkWell(
//                                 onTap: () {
//                                   if (text.isNotEmpty) sendComments();
//                                   for (var i = 0;
//                                       i < getimydata.data.length;
//                                       i++)
//                                     SocketNew.sendmessageSoket(
//                                         widget.userid,
//                                         getimydata.data[i].username,
//                                         text,
//                                         false,
//                                         '');

//                                   setState(() {
//                                     text = '';
//                                   });
//                                 },
//                                 child: Icon(Icons.send)),

//                     if (audioPath != null)
//                       InkWell(
//                           onTap: () async {
//                             _sendMessgAudio(audioPath);
//                             SocketNew.sendMessgaSoketMedia(
//                                 widget.userid, audioPath, _filename, 'audio');

//                             final path = await _audioRecorder.stop();
//                             setState(() {
//                               if (path != null) {
//                                 audioPath = null;
//                                 path != null;
//                               }
//                             });
//                           },
//                           child: Icon(Icons.send)),
//                     if (ImagePost != null)
//                       InkWell(
//                           onTap: () async {
//                             _sendMessgAudio(ImagePost!.path);
//                             SocketNew.sendMessgaSoketMedia(widget.userid,
//                                 ImagePost!.path, 'image', 'image');

//                             setState(() {
//                               if (ImagePost != null) {
//                                 ImagePost = null;
//                               }
//                             });
//                           },
//                           child: Icon(Icons.send))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         appBar: AppBar(
//           leadingWidth: 20,
//           centerTitle: false,
//           foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
//           backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(100),
//                     child: CachedNetworkImage(
//                       height: 35,
//                       width: 35,
//                       imageUrl: widget.avat,
//                       errorWidget: (context, url, error) {
//                         return ClipRRect(
//                           borderRadius: BorderRadius.circular(100),
//                           child: CachedNetworkImage(
//                               imageUrl:
//                                   '${accounts[0]['url']}/upload/photos/d-avatar.jpg'),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.01,
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.name,
//                         style: GoogleFonts.cairo(
//                             fontWeight: FontWeight.w800, fontSize: 16),
//                       ),
//                       if (witter == false)
//                         Text(
//                           'online'.tr,
//                           style: TextStyle(fontSize: 12),
//                         ),
//                       if (witter)
//                         Text(
//                           'He writes...'.tr,
//                           style: TextStyle(fontSize: 12),
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   InkWell(
//                       onTap: () async {
//                         print('ameen');
//                         var calls =
//                             await ApiCallsAgora.calls(widget.userid, 'audio');
//                         SocketNew.calssSokeit(widget.userid, 'audio',
//                             calls['room_name'], calls['token'], calls['id']);
//                         // Get.to(VidoCallScreen(
//                         //   user_id: widget.userid,
//                         //   channel: calls['room_name'],
//                         //   token: calls['token'],
//                         // ));
//                       },
//                       child:
//                           SvgPicture.asset('assets/images/svg/Group Copy.svg')),
//                   SizedBox(
//                     width: Get.width * 0.01,
//                   ),
//                   InkWell(
//                       onTap: () async {
//                         print('ameen');
//                         var calls =
//                             await ApiCallsAgora.calls(widget.userid, 'video');
//                         SocketNew.calssSokeit(widget.userid, 'video',
//                             calls['room_name'], calls['token'], calls['id']);
//                         // Get.to(VidoCallScreen(
//                         //   user_id: widget.userid,
//                         //   channel: calls['room_name'],
//                         //   token: calls['token'],
//                         // ));
//                       },
//                       child:
//                           SvgPicture.asset('assets/images/svg/CameraCall.svg')),
//                 ],
//               )
//             ],
//           ),
//         ),
//         body: Container(
//           height: Get.height,
//           width: Get.width,
//           child: Stack(
//             children: [
//               Container(
//                 height: openKey ? Get.height * 0.40 : Get.height * 0.77,
//                 width: Get.width,
//                 child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     reverse: true,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           for (var i = 0; i < data.length; i++)
//                             Column(
//                               children: [
//                                 //left

//                                 if (data[i].position == 'left')
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: _ChatLift(data: data, i: i),
//                                   ),

//                                 ////right

//                                 if (data[i].position == 'right')
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: _ChatRight(data: data, i: i),
//                                   ),
//                               ],
//                             ),
//                         ],
//                       ),
//                     )),
//               ),
//               if (ImagePost != null)
//                 Positioned(
//                   top: 8,
//                   child: Container(
//                     color: Theme.of(context).dialogBackgroundColor,
//                     width: Get.width,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(30),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                       width: 100,
//                                       height: 80,
//                                       child: Image.file(
//                                         File(ImagePost!.path),
//                                         fit: BoxFit.cover,
//                                       )),
//                                   IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           ImagePost = null;
//                                         });
//                                       },
//                                       icon: Icon(Icons.delete))
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//               // if (emojiShowing)
//               //   Container(
//               //     height: Get.height * 0.30,
//               //     child: EmojiPicker(
//               //       textEditingController: textfiled,
//               //       config: Config(
//               //         columns: 7,
//               //         // Issue: https://github.com/flutter/flutter/issues/28894
//               //         emojiSizeMax: 32 *
//               //             (foundation.defaultTargetPlatform == TargetPlatform.iOS
//               //                 ? 1.30
//               //                 : 1.0),
//               //         verticalSpacing: 0,
//               //         horizontalSpacing: 0,
//               //         gridPadding: EdgeInsets.zero,
//               //         initCategory: Category.RECENT,
//               //         bgColor: const Color(0xFFF2F2F2),
//               //         indicatorColor: Colors.blue,
//               //         iconColor: Colors.grey,
//               //         iconColorSelected: Colors.blue,
//               //         backspaceColor: Colors.blue,
//               //         skinToneDialogBgColor: Colors.white,
//               //         skinToneIndicatorColor: Colors.grey,
//               //         enableSkinTones: true,
//               //         showRecentsTab: true,
//               //         recentsLimit: 28,
//               //         replaceEmojiOnLimitExceed: false,
//               //         noRecents: const Text(
//               //           'No Recents',
//               //           style: TextStyle(fontSize: 20, color: Colors.black26),
//               //           textAlign: TextAlign.center,
//               //         ),
//               //         loadingIndicator: const SizedBox.shrink(),
//               //         tabIndicatorAnimDuration: kTabScrollDuration,
//               //         categoryIcons: const CategoryIcons(),
//               //         buttonMode: ButtonMode.MATERIAL,
//               //         checkPlatformCompatibility: true,
//               //       ),
//               //     ),
//               //   ),

//               WillPopScope(
//                 onWillPop: (() async {
//                   return EmojiGifPickerPanel.onWillPop();
//                 }),
//                 child: EmojiGifMenuLayout(
//                   child: SizedBox(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget WidgetPhotoAnvideo(camera) {
//     return Container(
//       width: Get.width,
//       height: Get.height * 0.40,
//       decoration: BoxDecoration(
//           color:
//               Get.isDarkMode ? Color.fromARGB(255, 31, 30, 30) : Colors.white,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: 20,
//           right: 20,
//           bottom: 15,
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: Get.height * 0.04),
//             InkWell(
//               onTap: () {
//                 UplodeImage(ImageSource.gallery);
//               },
//               child: Row(
//                 children: [
//                   Container(
//                     height: Get.height * 0.06,
//                     width: Get.width * 0.14,
//                     decoration: BoxDecoration(
//                         color: Color(0xffFEEEF0),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(7.0),
//                       child: Center(
//                         child: Image.asset(
//                           'assets/images/SDF.png',
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                   Text(
//                     'Images / Gallery'.tr,
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: Get.height * 0.02),
//             InkWell(
//               onTap: () => vedioupolde(ImageSource.gallery),
//               child: Row(
//                 children: [
//                   Container(
//                     height: Get.height * 0.06,
//                     width: Get.width * 0.14,
//                     decoration: BoxDecoration(
//                         color: Color(0xffFEEEF0),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(7.0),
//                       child: Center(
//                         child: Image.asset(
//                           'assets/images/youtube.png',
//                           color: colorTextBordingDark1,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                   Text(
//                     'Video / Gallery'.tr,
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: Get.height * 0.02),
//             InkWell(
//               onTap: () => UplodeImage(ImageSource.camera),
//               child: Row(
//                 children: [
//                   Container(
//                     height: Get.height * 0.06,
//                     width: Get.width * 0.14,
//                     decoration: BoxDecoration(
//                         color: Color(0xffFEEEF0),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(7.0),
//                       child: Center(
//                           child: SvgPicture.asset(
//                         'assets/images/svg/camera-svgrepo-com.svg',
//                         color: Colors.green,
//                       )),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                   Text(
//                     'Images / Camera'.tr,
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: Get.height * 0.02),
//             InkWell(
//               onTap: () => vedioupolde(ImageSource.camera),
//               child: Row(
//                 children: [
//                   Container(
//                     height: Get.height * 0.06,
//                     width: Get.width * 0.14,
//                     decoration: BoxDecoration(
//                         color: Color(0xffFEEEF0),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(7.0),
//                       child: Center(
//                           child: SvgPicture.asset(
//                         'assets/images/svg/camera-svgrepo-com.svg',
//                         color: Colors.red,
//                       )),
//                     ),
//                   ),
//                   SizedBox(
//                     width: Get.width * 0.03,
//                   ),
//                   Text(
//                     'Video / Camera'.tr,
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: Get.height * 0.02),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRecordStopControl() {
//     late Icon icon;
//     late Color color;

//     if (_recordState != RecordState.stop) {
//       icon = const Icon(Icons.stop, color: Colors.red, size: 30);
//       color = Get.isDarkMode ? Colors.white : Colors.red.withOpacity(0.1);
//     } else {
//       final theme = Theme.of(context);
//       icon = Icon(
//         Icons.mic,
//         color: Get.isDarkMode ? Colors.white : Colors.blue,
//       );
//       color = Get.isDarkMode ? Colors.blue : Colors.red.withOpacity(0.1);
//       ;
//     }

//     return ClipOval(
//       child: Material(
//         color: color,
//         child: InkWell(
//           child: Padding(
//             padding: const EdgeInsets.all(3.0),
//             child: icon,
//           ),
//           onTap: () {
//             (_recordState != RecordState.stop) ? _stop() : _start();
//           },
//         ),
//       ),
//     );
//   }
// }

// class _ChatLift extends StatefulWidget {
//   const _ChatLift({
//     super.key,
//     required this.data,
//     required this.i,
//   });

//   final List<GetAllMesageModel> data;
//   final int i;

//   @override
//   State<_ChatLift> createState() => _ChatLiftState();
// }

// class _ChatLiftState extends State<_ChatLift> {
//   String likeText = 'like2';

//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               backgroundImage:
//                   CachedNetworkImageProvider(widget.data[widget.i].avatar),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius:
//                       BorderRadius.only(bottomRight: Radius.circular(12))),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
//                 child: Container(
//                   width: Get.width - 150,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (widget.data[widget.i].text.isNotEmpty)
//                         if (widget.data[widget.i].reply_id.isNotEmpty)
//                           Container(
//                             child: Stack(children: [
//                               BubbleSpecialThree(
//                                 text: widget.data[widget.i].text,
//                                 color: Color(0xFFE8E8EE),
//                                 tail: true,
//                                 isSender: false,
//                               ),
//                             ]),
//                           ),
//                       if (widget.data[widget.i].reply_id.isEmpty)
//                         BubbleSpecialThree(
//                           text: widget.data[widget.i].text,
//                           color: Color(0xFFE8E8EE),
//                           tail: true,
//                           isSender: false,
//                         ),
//                       if (widget.data[widget.i].swowondertimelineflutterappers.isNotEmpty)
//                         CachedNetworkImage(
//                             imageUrl: widget.data[widget.i].swowondertimelineflutterappers),
//                       if (widget.data[widget.i].media.isAudioFileName)
//                         _MediaChat(
//                           media: widget.data[widget.i].media,
//                         ),
//                       if (widget.data[widget.i].media.isVideoFileName)
//                         VideoListChat(
//                             videoPlayerController:
//                                 VideoPlayerController.network(
//                               widget.data[widget.i].media,
//                             ),
//                             looping: true),
//                       if (widget.data[widget.i].media.endsWith(".m4a"))
//                         _MediaChat(
//                           media: widget.data[widget.i].media,
//                         ),
//                       if (widget.data[widget.i].media.isImageFileName)
//                         BubbleNormalImage(
//                           id: widget.data[widget.i].id,
//                           image: CachedNetworkImage(
//                             imageUrl: widget.data[widget.i].media,
//                             errorWidget: (context, url, error) => Image.file(
//                                 File(widget.data[widget.i].media),
//                                 errorBuilder: (context, error, stackTrace) =>
//                                     Image.file(File(
//                                       widget.data[widget.i].media,
//                                     ))),
//                           ),
//                           tail: false,
//                           delivered: false,
//                         ),
//                       InkWell(
//                         onTap: () {
//                           Get.dialog(
//                             Directionality(
//                               textDirection: TextDirection.ltr,
//                               child: Center(
//                                 child: Container(
//                                     width: Get.width * 0.80,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20),
//                                         color: Theme.of(context)
//                                             .scaffoldBackgroundColor),
//                                     child: Center(
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Scaffold(
//                                           body: Center(
//                                               child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               InkWell(
//                                                 onTap: () async {
//                                                   SocketNew.LikeMessageSoc(
//                                                       widget.data[widget.i].id,
//                                                       '1');
//                                                   Get.back();
//                                                 },
//                                                 child: Image.asset(
//                                                   'assets/images/svgexport-6 - 2022-09-18T192746.492.png',
//                                                   height: 40,
//                                                   width: 40,
//                                                 ),
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   SocketNew.LikeMessageSoc(
//                                                       widget.data[widget.i].id,
//                                                       '2');
//                                                   Get.back();
//                                                 },
//                                                 child: Image.asset(
//                                                   'assets/images/love2.png',
//                                                   height: 40,
//                                                   width: 40,
//                                                 ),
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   SocketNew.LikeMessageSoc(
//                                                       widget.data[widget.i].id,
//                                                       '3');
//                                                   Get.back();
//                                                 },
//                                                 child: Image.asset(
//                                                   'assets/images/haha2.png',
//                                                   height: 40,
//                                                   width: 40,
//                                                 ),
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   SocketNew.LikeMessageSoc(
//                                                       widget.data[widget.i].id,
//                                                       '4');
//                                                   Get.back();
//                                                 },
//                                                 child: Image.asset(
//                                                   'assets/images/haha2.png',
//                                                   height: 40,
//                                                   width: 40,
//                                                 ),
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   SocketNew.LikeMessageSoc(
//                                                       widget.data[widget.i].id,
//                                                       '5');
//                                                   Get.back();
//                                                 },
//                                                 child: Image.asset(
//                                                   'assets/images/sad2.png',
//                                                   height: 40,
//                                                   width: 40,
//                                                 ),
//                                               ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   SocketNew.LikeMessageSoc(
//                                                       widget.data[widget.i].id,
//                                                       '6');
//                                                   Get.back();
//                                                 },
//                                                 child: Image.asset(
//                                                   'assets/images/angry2.png',
//                                                   height: 40,
//                                                   width: 40,
//                                                 ),
//                                               ),
//                                             ],
//                                           )),
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                             ),
//                           );
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (widget.data[widget.i].reaction['is_reacted'] ==
//                                 false)
//                               Container(
//                                   height: 20,
//                                   width: 20,
//                                   decoration: BoxDecoration(
//                                       color: colorTextBordingDark1,
//                                       shape: BoxShape.circle),
//                                   child: Center(
//                                     child: Icon(
//                                       Icons.add,
//                                       color: Colors.white,
//                                       size: 20,
//                                     ),
//                                   )),
//                             if (widget.data[widget.i].reaction['1'] != null)
//                               Image.asset(
//                                 'assets/images/svgexport-6 - 2022-09-18T192746.492.png',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                             if (widget.data[widget.i].reaction['2'] != null)
//                               Image.asset(
//                                 'assets/images/love2.png',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                             if (widget.data[widget.i].reaction['3'] != null)
//                               Image.asset(
//                                 'assets/images/haha2.png',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                             if (widget.data[widget.i].reaction['4'] != null)
//                               Image.asset(
//                                 'assets/images/haha2.png',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                             if (widget.data[widget.i].reaction['5'] != null)
//                               Image.asset(
//                                 'assets/images/sad2.png',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                             if (widget.data[widget.i].reaction['6'] != null)
//                               Image.asset(
//                                 'assets/images/angry2.png',
//                                 height: 20,
//                                 width: 20,
//                               ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: Get.height * 0.01,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(4),
//                           color: Color(0x558AD3D5),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Text(widget.data[widget.i].time_text),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: Get.width * 0.01,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _MediaChat extends StatefulWidget {
//   _MediaChat({required this.media, super.key});
//   String media;

//   @override
//   State<_MediaChat> createState() => __MediaChatState();
// }

// class __MediaChatState extends State<_MediaChat> {
//   final _player = AudioPlayer();
//   Duration duration = new Duration();
//   Duration position = new Duration();
//   bool isPlaying = false;
//   bool isLoading = false;
//   bool isPause = false;
//   @override
//   bindPlayer() async {
//     await _player.setUrl(widget.media);
//     duration = _player.duration!;
//     setState(() {});
//     _player.positionStream.listen((event) {
//       Duration temp = event as Duration;
//       position = temp;
//       setState(() {});
//     });
//   }

//   playAction() {
//     if (isPlaying) {
//       setState(() {});
//       _player.pause();
//       isPlaying = false;
//       print(isPlaying);
//     } else {
//       setState(() {});
//       _player.play();
//       isPlaying = true;
//       print(isPlaying);
//     }
//   }

//   @override
//   void initState() {
//     bindPlayer();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BubbleNormalAudio(
//         color: Get.isDarkMode ? Colors.black : Color(0xFFE8E8EE),
//         duration: duration.inSeconds.toDouble(),
//         position: position.inSeconds.toDouble(),
//         isPlaying: isPlaying,
//         isLoading: isLoading,
//         // fillColor:
//         //     Get.isDarkMode ? Color.fromARGB(106, 31, 31, 31) : Colors.white,
//         isPause: isPause,
//         bubbleRadius: 50,
//         seen: false,
//         sent: true,
//         textStyle:
//             TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
//         onSeekChanged: (value) async {
//           final seekPostintion = Duration(seconds: value.toInt());
//           await _player.seek(seekPostintion);
//         },
//         onPlayPauseButtonClick: playAction);
//   }

//   String foramtTime(Duration value) {
//     String twoDigit(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigit(value.inHours);
//     final min = twoDigit(value.inMinutes.remainder(60));
//     final sec = twoDigit(value.inSeconds.remainder(60));
//     return [if (value.inHours > 0) hours, min, sec].join(':');
//   }
// }

// class _ChatRight extends StatefulWidget {
//   const _ChatRight({
//     super.key,
//     required this.data,
//     required this.i,
//   });

//   final List<GetAllMesageModel> data;
//   final int i;

//   @override
//   State<_ChatRight> createState() => _ChatRightState();
// }

// class _ChatRightState extends State<_ChatRight> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   bool listen = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               child: Container(
//                 width: Get.width - 100,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     if (widget.data[widget.i].text.isNotEmpty)
//                       BubbleSpecialThree(
//                           text: widget.data[widget.i].text,
//                           color: Color(0xFF1B97F3),
//                           tail: true,
//                           textStyle:
//                               TextStyle(color: Colors.white, fontSize: 16),
//                           seen:
//                               widget.data[widget.i].seen == '0' ? false : true,
//                           sent: true),
//                     if (widget.data[widget.i].swowondertimelineflutterappers.isNotEmpty)
//                       CachedNetworkImage(
//                           imageUrl: widget.data[widget.i].swowondertimelineflutterappers),
//                     if (widget.data[widget.i].media.endsWith(".m4a"))
//                       _MediaChat(
//                         media: widget.data[widget.i].media,
//                       ),
//                     if (widget.data[widget.i].media.isVideoFileName)
//                       VideoListChat(
//                         videoPlayerController: VideoPlayerController.network(
//                           widget.data[widget.i].media,
//                         ),
//                         looping: true,
//                       ),
//                     if (widget.data[widget.i].media.endsWith('mov'))
//                       VideoListChat(
//                         videoPlayerController: VideoPlayerController.network(
//                           widget.data[widget.i].media,
//                         ),
//                         looping: true,
//                       ),
//                     if (widget.data[widget.i].media.isAudioFileName)
//                       _MediaChat(
//                         media: widget.data[widget.i].media,
//                       ),
//                     if (widget.data[widget.i].media.isImageFileName)
//                       BubbleNormalImage(
//                         id: widget.data[widget.i].id,
//                         image: CachedNetworkImage(
//                           imageUrl: widget.data[widget.i].media,
//                           errorWidget: (context, url, error) =>
//                               Image.file(File(widget.data[widget.i].media)),
//                         ),
//                         tail: true,
//                         delivered:
//                             widget.data[widget.i].seen == '0' ? false : true,
//                         sent: true,
//                       ),
//                     InkWell(
//                       onTap: () {
//                         Get.dialog(
//                           Directionality(
//                             textDirection: TextDirection.ltr,
//                             child: Center(
//                               child: Container(
//                                   width: Get.width * 0.80,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Theme.of(context)
//                                           .scaffoldBackgroundColor),
//                                   child: Center(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Scaffold(
//                                         body: Center(
//                                             child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             InkWell(
//                                               onTap: () async {
//                                                 SocketNew.LikeMessageSoc(
//                                                     widget.data[widget.i].id,
//                                                     '1');
//                                                 Get.back();
//                                               },
//                                               child: Image.asset(
//                                                 'assets/images/svgexport-6 - 2022-09-18T192746.492.png',
//                                                 height: 40,
//                                                 width: 40,
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 SocketNew.LikeMessageSoc(
//                                                     widget.data[widget.i].id,
//                                                     '2');
//                                                 Get.back();
//                                               },
//                                               child: Image.asset(
//                                                 'assets/images/love2.png',
//                                                 height: 40,
//                                                 width: 40,
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 SocketNew.LikeMessageSoc(
//                                                     widget.data[widget.i].id,
//                                                     '3');
//                                                 Get.back();
//                                               },
//                                               child: Image.asset(
//                                                 'assets/images/haha2.png',
//                                                 height: 40,
//                                                 width: 40,
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 SocketNew.LikeMessageSoc(
//                                                     widget.data[widget.i].id,
//                                                     '4');
//                                                 Get.back();
//                                               },
//                                               child: Image.asset(
//                                                 'assets/images/haha2.png',
//                                                 height: 40,
//                                                 width: 40,
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 SocketNew.LikeMessageSoc(
//                                                     widget.data[widget.i].id,
//                                                     '5');
//                                                 Get.back();
//                                               },
//                                               child: Image.asset(
//                                                 'assets/images/sad2.png',
//                                                 height: 40,
//                                                 width: 40,
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 SocketNew.LikeMessageSoc(
//                                                     widget.data[widget.i].id,
//                                                     '6');
//                                                 Get.back();
//                                               },
//                                               child: Image.asset(
//                                                 'assets/images/angry2.png',
//                                                 height: 40,
//                                                 width: 40,
//                                               ),
//                                             ),
//                                           ],
//                                         )),
//                                       ),
//                                     ),
//                                   )),
//                             ),
//                           ),
//                         );
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           if (widget.data[widget.i].reaction['is_reacted'] ==
//                               false)
//                             Container(
//                                 height: 20,
//                                 width: 20,
//                                 decoration: BoxDecoration(
//                                     color: colorTextBordingDark1,
//                                     shape: BoxShape.circle),
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.add,
//                                     color: Colors.white,
//                                     size: 20,
//                                   ),
//                                 )),
//                           if (widget.data[widget.i].reaction['1'] != null)
//                             Image.asset(
//                               'assets/images/svgexport-6 - 2022-09-18T192746.492.png',
//                               height: 20,
//                               width: 20,
//                             ),
//                           if (widget.data[widget.i].reaction['2'] != null)
//                             Image.asset(
//                               'assets/images/love2.png',
//                               height: 20,
//                               width: 20,
//                             ),
//                           if (widget.data[widget.i].reaction['3'] != null)
//                             Image.asset(
//                               'assets/images/haha2.png',
//                               height: 20,
//                               width: 20,
//                             ),
//                           if (widget.data[widget.i].reaction['4'] != null)
//                             Image.asset(
//                               'assets/images/haha2.png',
//                               height: 20,
//                               width: 20,
//                             ),
//                           if (widget.data[widget.i].reaction['5'] != null)
//                             Image.asset(
//                               'assets/images/sad2.png',
//                               height: 20,
//                               width: 20,
//                             ),
//                           if (widget.data[widget.i].reaction['6'] != null)
//                             Image.asset(
//                               'assets/images/angry2.png',
//                               height: 20,
//                               width: 20,
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             CircleAvatar(
//               backgroundImage:
//                   CachedNetworkImageProvider(widget.data[widget.i].avatar),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class LiftChat extends StatelessWidget {
//   const LiftChat({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: [
//           CircleAvatar(),
//           SizedBox(
//             width: Get.width * 0.01,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.none,
//                     image: AssetImage(
//                         'assets/images/svg/PlaceholderBacRound.png'))),
//             child: Container(
//               width: Get.width * 0.70,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('Hello'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RihtChat extends StatelessWidget {
//   const RihtChat({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       right: 1,
//       child: Container(
//         child: Row(
//           children: [
//             SizedBox(
//               width: Get.width * 0.01,
//             ),
//             Container(
//               decoration: BoxDecoration(color: Color(0xffDCE7FF)),
//               child: Row(
//                 children: [
//                   Container(
//                     width: Get.width * 0.70,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text('HelloHelloHelloHelloHelloHello'),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CircleAvatar(),
//           ],
//         ),
//       ),
//     );
//   }
// }
