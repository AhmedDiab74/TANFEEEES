import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/ReportScreen.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/MessengerProfile/UserMedia.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/MessengerProfile/ChatBackgroundScreen.dart';

class MessengerProfile extends StatelessWidget {
  MessengerProfile({
    required this.user_id,
    required this.name,
    required this.username,
    required this.avatar,
    required this.color_chat,
    required this.update,
    super.key,
  });
  final update;
  final user_id;
  final String name;
  final String username;
  final color_chat;
  final avatar;
  final String postLink = accounts[0]['sm0'];

  Widget _ColorChat(color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: CircleAvatar(
          maxRadius: 1,
          backgroundColor:
              Color(int.parse(color.toString().replaceAll('#', '0xff'))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(avatar),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      name,
                      style: SafeGoogleFont(Fonts.font3,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChatProfileButtons(
                  text: 'Call'.tr,
                  icons: Icons.call,
                  onTap: () async {},
                ),
                ChatProfileButtons(
                  text: 'Video'.tr,
                  icons: Icons.camera,
                  onTap: () async {},
                ),
                ChatProfileButtons(
                  text: 'Profile'.tr,
                  icons: Icons.person,
                  onTap: () async {
                    Get.to(ProfileUserScreen(
                      avat: avatar,
                      cover: avatar,
                      name: name,
                      user_id: user_id,
                    ));
                  },
                ),
                ChatProfileButtons(
                  text: 'Mute'.tr,
                  icons: Icons.notifications_off,
                  onTap: () async {},
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Menu',
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ChatMenu(
                    id: 1,
                    text: 'Chat Color'.tr,
                    icons: Icons.call,
                    isColorMenu: true,
                    color_chat: color_chat,
                    onTap: () async {
                      Get.bottomSheet(Container(
                          height: Get.height * 0.40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Container(
                                        width: 70,
                                        height: 3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      Text('Color Chat'.tr)
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: Get.width,
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                height: Get.height * 0.31,
                                child: GridView.count(
                                  crossAxisCount: 6,
                                  children: [
                                    _ColorChat('#2b87ce'),
                                    _ColorChat('#008484'),
                                    _ColorChat('#f2812b'),
                                    _ColorChat('#5462a5'),
                                    _ColorChat('#ed9e6a'),
                                    _ColorChat('#fc9cde'),
                                    _ColorChat('#a085e2'),
                                    _ColorChat('#51bcbc'),
                                    _ColorChat('#a1ce79'),
                                    _ColorChat('#70a0e0'),
                                    _ColorChat('#aa2294'),
                                    _ColorChat('#8ec96c'),
                                    _ColorChat('#f9c270'),
                                    _ColorChat('#f33d4c'),
                                    _ColorChat('#609b41'),
                                    _ColorChat('#0e71ea'),
                                    _ColorChat('#a84849'),
                                    _ColorChat('#ff72d2'),
                                    _ColorChat('#56c4c5'),
                                    _ColorChat('#0ba05d'),
                                    _ColorChat('#f9a722'),
                                    _ColorChat('#01a5a5'),
                                    _ColorChat('#056bba'),
                                    _ColorChat('#b582af'),
                                  ],
                                ),
                              ),
                            ],
                          )));
                    },
                  ),
                  ChatMenu(
                    id: 2,
                    text: 'View media, files & links'.tr,
                    icons: Icons.photo,
                    isColorMenu: false,
                    color_chat: color_chat,
                    onTap: () async {
                      Get.to(MessengerUserMedia());
                    },
                  ),
                  ChatMenu(
                    id: user_id,
                    text: 'Chat Background'.tr,
                    icons: Icons.backup_rounded,
                    isColorMenu: false,
                    color_chat: color_chat,
                    onTap: () async {
                      Get.to(ChatBackgroundScreen(
                        update: update,
                        user_id: user_id,
                      ));
                    },
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: Get.height * 0.04,
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Menu',
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ChatMenu(
                    id: 1,
                    text: 'Share'.tr,
                    icons: Icons.share,
                    color_chat: color_chat,
                    isColorMenu: false,
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ShareButton(
                              postLink: postLink + '/' + username,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ChatMenu(
                    id: user_id,
                    text: 'Block'.tr,
                    icons: Icons.block,
                    isColorMenu: false,
                    color_chat: color_chat,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Do you want to Block this Person?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  ChatMenu(
                    id: 3,
                    text: 'Report'.tr,
                    icons: Icons.report,
                    isColorMenu: false,
                    color_chat: color_chat,
                    onTap: () async {
                      Get.dialog(WidgetReportUser(
                          user_id: user_id, name: name, Report: name));
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class ChatMenu extends StatelessWidget {
  ChatMenu({
    required this.id,
    required this.text,
    required this.icons,
    required this.isColorMenu,
    required this.color_chat,
    this.onTap,
    super.key,
  });

  final id;
  final String text;
  final icons;
  final onTap;
  final color_chat;
  bool isColorMenu;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
              isColorMenu
                  ? Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: color_chat,
                          borderRadius: BorderRadius.circular(50)),
                    )
                  : Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50)),
                      child: Icon(
                        icons,
                        size: 15,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class ChatProfileButtons extends StatelessWidget {
  ChatProfileButtons({
    required this.text,
    required this.icons,
    this.onTap,
    super.key,
  });

  final String text;
  final icons;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(50)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (onTap != null) onTap();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Icon(
                  icons,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.006,
        ),
        Text(
          text,
          style: SafeGoogleFont(Fonts.font2,
              fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black),
        )
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  ShareButton({
    required this.postLink,
    super.key,
  });

  final String postLink;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Share Modal'),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.close_outlined))
            ],
          ),
          Divider(),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Facebook
              SocialShareLinks(
                icons: Icons.facebook,
                color: Color(0xff1877F2),
                onTap: () async {
                  launch(
                      'https://www.facebook.com/sharer/sharer.php?u=$postLink');
                },
              ),
              // Twitter
              SocialShareLinks(
                icons: Icons.facebook,
                color: Color(0xff1877F2),
                onTap: () async {
                  launch(
                      'https://www.facebook.com/sharer/sharer.php?u=$postLink');
                },
              ),
              // Linkedin
              SocialShareLinks(
                icons: Icons.linked_camera,
                color: Color(0xff1877F2),
                onTap: () async {
                  launch(
                      'https://www.facebook.com/sharer/sharer.php?u=$postLink');
                },
              ),
              // Reddit
              SocialShareLinks(
                icons: Icons.facebook,
                color: Color(0xff1877F2),
                onTap: () async {
                  launch(
                      'https://www.facebook.com/sharer/sharer.php?u=$postLink');
                },
              ),
              // Pinterest
              SocialShareLinks(
                icons: Icons.more_horiz,
                color: Color(0xff1877F2),
                onTap: () async {
                  Get.back();
                  Share.share(postLink);
                },
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Or Copy link',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.grey)),
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.link),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(Stringlength(text: postLink, length: 22)),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: postLink));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Link copied to clipboard'),
                    ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                        color: Color(0xff7D2AE8),
                        borderRadius: BorderRadius.circular(3)),
                    child: Text(
                      'Copy',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialShareLinks extends StatelessWidget {
  SocialShareLinks({
    required this.color,
    required this.icons,
    this.onTap,
    super.key,
  });

  final color;
  final icons;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: color)),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              icons,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
