import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Widget/NotFoundWidget.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/OnePostScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/notifi_service.dart';
import 'package:wowondertimelineflutterapp/Screens/HelpAndSupport/RateMyApp.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/NotificationsApi.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/NotificationsModels.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool loding = true;
  bool noData = true;

  @override
  void initState() {
    GetNorfi();

    super.initState();
  }

  List<NotificationsModels> notfi = [];

  void GetNorfi() async {
    try {
      NotificationsApi.Notifications().then((value) {
        setState(() {
          notfi = value.toList();

          setState(() {
            loding = false;
            noData = false;
          });

          // print(notfi);
        });
      });
      var list = await NotificationsApi.Notifications();
    } catch (erorr) {
      setState(() {
        loding = false;
        noData = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            Get.isDarkMode ? ColorDarkBackground : Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          title: Text('Notfications'.tr),
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          elevation: 0,
        ),
        body: loding
            ? Center(child: LoadingProgressBarr())
            : noData
                ? NotFoundWidget(
                    text: 'There are no notifications yet.'.tr,
                  )
                : SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 5,
                      ),
                      for (var i = 0; i < notfi.length; i++)
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? ColorDarkComponents
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print(notfi[i].type);
                                var not = notfi[i].type;

                                if (not == 'comment')
                                  Get.to(OnePostScreenGo(
                                    post_id: notfi[i].post_id,
                                    title: not,
                                  ));
                                if (not == 'reaction')
                                  Get.to(OnePostScreenGo(
                                    post_id: notfi[i].post_id,
                                    title: notfi[i].type_text,
                                  ));
                                if (not == 'following')
                                  Get.to(ProfileUserScreen(
                                    avat: notfi[i].avatar,
                                    cover: notfi[i].cover,
                                    name: notfi[i].name,
                                    user_id: notfi[i].user_id,
                                  ));
                                if (not == 'visited_profile')
                                  Get.to(ProfileUserScreen(
                                    avat: notfi[i].avatar,
                                    cover: notfi[i].cover,
                                    name: notfi[i].name,
                                    user_id: notfi[i].user_id,
                                  ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  notfi[i].avatar),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: Get.width * 0.59,
                                                  child: Text(
                                                    notfi[i].name,
                                                    style: SafeGoogleFont(
                                                        Fonts.font1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  )),
                                              Container(
                                                width: Get.width * 0.59,
                                                child: Text(notfi[i].type_text),
                                              )
                                            ])
                                      ],
                                    ),
                                    Text(notfi[i].time_text_string),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    ]),
                  ));
  }
}

var dekodeko2 = DekDek2.decrypted;
