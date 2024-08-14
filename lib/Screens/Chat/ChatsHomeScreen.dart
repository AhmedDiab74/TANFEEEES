import 'dart:async';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Util/ListMangmingHelper.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/Widget/Unfous.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingPosts.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/NoChatScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/AddMemberChat.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/ReportScreen.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiDeleteChat.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetAllChatsApi.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/page/HomePage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllChatsModel.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/page/AppOpenPage.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GetSingleUserMessageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/components/HideKeyboard.dart';

class ChatsHomeScreen extends StatefulWidget {
  const ChatsHomeScreen({super.key});

  @override
  State<ChatsHomeScreen> createState() => _ChatsHomeScreenState();
}

class _ChatsHomeScreenState extends State<ChatsHomeScreen> {
  bool loding = true;
  bool nodata = false;
  bool deleteTreu = false;
  List<GetAllChatsModel> data = [];
  final Config = GetSetList[0];

  void getalhat() async {
    await GetAllChatsApi.allChat('0').then((value) {
      setState(() {
        data = value.toList();
        loding = false;
        value.length > 0 ? '' : nodata = true;
      });
    });
  }

  void onLineUser() {
    ///online
    SocketNew.socket.on(
        'on_user_loggedin',
        (dataonLine) async => {
              if (mounted)
                {
                  getalhat(),
                }
            });
  }

  Future<void> soketGetdattt() async {
    //جلب الماحدثه الجديده
    SocketNew.socket.on('private_message', (datasss) {
      if (mounted) {
        getalhat();
      }
      print('ameen');
    });
  }

  @override
  void initState() {
    getalhat();
    onLineUser();
    soketGetdattt();
    SocketNew.onncteSoket();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Unfous(
        child: Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Get.isDarkMode ? NavBarColorDark : ColorTheme,
        onPressed: () {
          Get.dialog(
            Center(
              child: AddMemberChat(
                getData: false,
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        title: Text('Messenger'.tr),
        elevation: 0,
        backgroundColor: Get.isDarkMode ? NavBarColorDark : ColorTheme,
        actions: [
          InkWell(
            onTap: () {
              Get.dialog(
                Center(
                  child: AddMemberChat(
                    getData: false,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(
                    width: 5,
                  ),
                  Text('New')
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Container(
            //       width: double.infinity,
            // height: Get.height * 0.06,
            //       margin: EdgeInsets.all(5),
            //       child: Column(children: [
            //         SizedBox(
            //           // height: 60,
            //           width: double.infinity,
            //           child: ListView.builder(scrollDirection: Axis.horizontal, itemBuilder: (ctx,index){
            //             return Container(
            //               margin: EdgeInsets.all(5),
            //               width: 10,
            //               height: Get.height * 0.02,
            //               decoration: BoxDecoration(color: Colors.red),
            //             );
            //           }),
            //         )
            //       ]),
            //     ),

            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              // height: Get.height * 0.85,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:
                            Get.isDarkMode ? Colors.white : Color(0xff2DE3E4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              SvgImages.Search,
                              color:
                                  Get.isDarkMode ? Colors.grey : Colors.white,
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            Container(
                                width: Get.width * 0.70,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search',
                                      hintStyle:
                                          TextStyle(color: Colors.black)),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (Config['groups'] == '1')
                    InkWell(
                      onTap: () {
                        // Get.to(ChatScreenGpt());
                        Get.to(SplashPage());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? Colors.white
                                : Color(0xff2DE3E4),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                Get.isDarkMode
                                    ? 'assets/icon.png'
                                    : 'assets/iconlight.png',
                                width: Get.height * 0.06,
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nameApp + ' Ai',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Text(
                                    'Let\'s Chat with $nameApp Ai'.tr,
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ],
                              )
                            ]),
                      ),
                    ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    // height: Get.height * 0.707,
                    child: SingleChildScrollView(
                      child: Container(
                        height: Get.height,
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: loding
                            ? LodingPostsWidget(
                                len: 5,
                              )
                            : nodata
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.1,
                                      ),
                                      NoChatScreen(
                                        startChat: true,
                                        textData: '',
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      for (var i = 0; i < data.length; i++)
                                        Dismissible(
                                          confirmDismiss: (direction) async {
                                            if (direction ==
                                                DismissDirection.endToStart) {
                                              await Dialogs.materialDialog(
                                                  color: Get.isDarkMode
                                                      ? Colors.black
                                                      : Colors.white,
                                                  msg:
                                                      'Are you sure you want to delete this Chat?',
                                                  title: data[i].name,
                                                  lottieBuilder: Lottie.asset(
                                                    AnimatedImages.DeleteChat,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  // customView: MySuperWidget(),
                                                  customViewPosition:
                                                      CustomViewPosition
                                                          .BEFORE_TITLE,
                                                  context: context,
                                                  actions: [
                                                    IconsButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          deleteTreu = false;
                                                        });
                                                        Get.back();
                                                      },
                                                      text: 'No',
                                                      iconData: Icons.cancel,
                                                      color: Colors.blue,
                                                      textStyle: TextStyle(
                                                          color: Colors.white),
                                                      iconColor: Colors.white,
                                                    ),
                                                    IconsButton(
                                                      onPressed: () {
                                                        ApiDeleteChat.dele(
                                                            use: data[i]
                                                                .user_id);
                                                        setState(() {
                                                          data.removeAt(i);

                                                          deleteTreu = true;
                                                        });

                                                        Get.back();
                                                      },
                                                      text: 'Yes',
                                                      iconData: Icons.done,
                                                      color: Colors.red,
                                                      textStyle: TextStyle(
                                                          color: Colors.white),
                                                      iconColor: Colors.white,
                                                    ),
                                                  ]);

                                              return deleteTreu;
                                            } else {
                                              // TODO: Navigate to edit page;
                                            }
                                          },
                                          background: slideRightBackground(),
                                          secondaryBackground:
                                              slideLeftBackground(),
                                          key: Key(data[i].name),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onLongPress: () {
                                                Get.bottomSheet(Container(
                                                    // height: Get.height * 0.40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                    ),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.01,
                                                                  ),
                                                                  Container(
                                                                    width: 70,
                                                                    height: 3,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: Colors
                                                                              .grey[
                                                                          300],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.01,
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.02,
                                                          ),
                                                          Container(
                                                              // height: Get.height *
                                                              //     0.31,
                                                              child:
                                                                  SingleChildScrollView(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              child: Column(
                                                                children: [
                                                                  LongPressMenu(
                                                                    icon: Icons
                                                                        .block,
                                                                    name:
                                                                        'Archive',
                                                                  ),
                                                                  LongPressMenu(
                                                                    onTap:
                                                                        () async {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text('Delete this Conversation?'),
                                                                            content:
                                                                                Text('Do you want to Block this Person?'),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                child: Text('Yes'),
                                                                                onPressed: () {
                                                                                  ApiDeleteChat.dele(use: data[i].user_id);
                                                                                  setState(() {
                                                                                    data.removeAt(i);

                                                                                    deleteTreu = true;
                                                                                    Get.back();
                                                                                  });

                                                                                  Get.back();
                                                                                },
                                                                              ),
                                                                              TextButton(
                                                                                child: Text('No'),
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    deleteTreu = false;
                                                                                  });
                                                                                  Get.back();
                                                                                },
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    icon: Icons
                                                                        .delete,
                                                                    name:
                                                                        'Delete',
                                                                  ),
                                                                  LongPressMenu(
                                                                    icon: Icons
                                                                        .notifications_off,
                                                                    name:
                                                                        'Mute',
                                                                  ),
                                                                  LongPressMenu(
                                                                    icon: Icons
                                                                        .block,
                                                                    name:
                                                                        'Block',
                                                                  ),
                                                                  LongPressMenu(
                                                                    onTap:
                                                                        () async {
                                                                      Get.back();
                                                                      Get.dialog(WidgetReportUser(
                                                                          user_id: data[i]
                                                                              .user_id,
                                                                          name: data[i]
                                                                              .name,
                                                                          Report:
                                                                              data[i].name));
                                                                    },
                                                                    icon: Icons
                                                                        .report,
                                                                    name:
                                                                        'Report ${data[i].name}',
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )),
                                                        ],
                                                      ),
                                                    )));
                                              },
                                              onTap: () {
                                                setState(() {
                                                  data.replaceAt(
                                                      i,
                                                      GetAllChatsModel(
                                                          reaction:
                                                              data[i].reaction,
                                                          lastseen_status: data[
                                                                  i]
                                                              .lastseen_status,
                                                          lastseen_unix_time: data[
                                                                  i]
                                                              .lastseen_unix_time,
                                                          onwer: data[i].onwer,
                                                          count: data[i].count,
                                                          message_count: '0',
                                                          time_text:
                                                              data[i].time_text,
                                                          time: data[i].time,
                                                          text: data[i].text,
                                                          user_id:
                                                              data[i].user_id,
                                                          username:
                                                              data[i].username,
                                                          name: data[i].name,
                                                          chat_color: data[i]
                                                              .chat_color,
                                                          avatar:
                                                              data[i].avatar));
                                                });
                                                Get.to(
                                                    GetSingleUserMessageScreen(
                                                  update: getalhat,
                                                  avat: data[i].avatar,
                                                  userid: data[i].user_id,
                                                  username: data[i].username,
                                                  name: data[i].name,
                                                  color: data[i].chat_color,
                                                  // color: data[i].chat_color,
                                                ));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8),
                                                child: Container(
                                                  // color:
                                                  //     data[i].message_count != '0'
                                                  //         ? Color.fromARGB(
                                                  //             255, 205, 233, 206)
                                                  //         : null,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              CircleAvatar(
                                                                maxRadius: 32,
                                                                backgroundImage:
                                                                    CachedNetworkImageProvider(
                                                                        data[i]
                                                                            .avatar),
                                                              ),
                                                              data[i].lastseen_status ==
                                                                      'on'
                                                                  ? Positioned(
                                                                      right: 2,
                                                                      bottom: 0,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: Colors.white),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              1.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                15,
                                                                            width:
                                                                                15,
                                                                            decoration:
                                                                                BoxDecoration(shape: BoxShape.circle, color: ColorTheme),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Positioned(
                                                                      right: 0,
                                                                      bottom: 0,
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: Colors.white),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              1.0),
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                                            // height:
                                                                            //     10,
                                                                            // width:
                                                                            //     10,
                                                                            decoration: BoxDecoration(
                                                                                color: ColorTheme,
                                                                                borderRadius: BorderRadius.circular(50),
                                                                                border: Border.all(width: 1, color: Colors.white)),

                                                                            child:
                                                                                Text(
                                                                              ConverttoTimeDayOnline(int.parse(data[i].lastseen_unix_time)),
                                                                              style: TextStyle(fontSize: 10, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: Get.width *
                                                                0.02,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        0.7465,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      Stringlength(
                                                                          text: data[i]
                                                                              .name,
                                                                          length:
                                                                              20),
                                                                      style: SafeGoogleFont(
                                                                          Fonts
                                                                              .font3,
                                                                          fontWeight: data[i].message_count != '0'
                                                                              ? FontWeight.w900
                                                                              : FontWeight.w500,
                                                                          fontSize: 16),
                                                                    ),
                                                                    data[i].message_count !=
                                                                            '0'
                                                                        ? Container(
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(5.0),
                                                                              child: Text(
                                                                                data[i].message_count.toString(),
                                                                                style: SafeGoogleFont(Fonts.font1, color: Colors.white, fontSize: 14),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : SizedBox(),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    Get.height *
                                                                        0.005,
                                                              ),
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        0.7465,
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        Stringlength(
                                                                          text: data[i].text.isNotEmpty
                                                                              // ? data[i]
                                                                              //     .text
                                                                              ? data[i].onwer == '1'
                                                                                  ? data[i].text
                                                                                  : 'You: ' + data[i].text
                                                                              : data[i].onwer == '1'
                                                                                  ? data[i].text + ' Send a File'
                                                                                  : 'You: Send a File',
                                                                          length:
                                                                              25,
                                                                        ),

                                                                        // When you type a message from another account then this happens
                                                                        style: SafeGoogleFont(
                                                                            Fonts
                                                                                .font3,
                                                                            fontWeight: data[i].message_count != '0'
                                                                                ? FontWeight.w900
                                                                                : FontWeight.w500,
                                                                            fontSize: 14,
                                                                            color: Colors.grey),
                                                                        maxLines:
                                                                            1,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          if (data[i]
                                                                              .time_text
                                                                              .isNotEmpty)
                                                                            Text(
                                                                              Stringlength(
                                                                                text: TimeStamp(data[i].time_text),
                                                                                length: 30,
                                                                              ),
                                                                              style: SafeGoogleFont(Fonts.font3, fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey),
                                                                              maxLines: 1,
                                                                            ),
                                                                        ],
                                                                      )
                                                                    ]),
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.archive,
              color: Colors.white,
            ),
            Text(
              " Archive",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      width: Get.width * 0.20,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: 60,
              height: 72,
              decoration: ShapeDecoration(
                color: Color.fromARGB(84, 255, 92, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Center(
                  child: SvgPicture.asset(
                SvgImages.Trash,
                color: Colors.red,
              )),
            ),
            SizedBox(
              width: 3,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}

class LongPressMenu extends StatelessWidget {
  LongPressMenu({
    required this.name,
    required this.icon,
    this.onTap,
    super.key,
  });

  final String name;
  final icon;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(
                  icon,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
