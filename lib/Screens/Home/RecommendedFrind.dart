import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Widget/LoadingWidgetStroy.dart';
import 'package:wowondertimelineflutterapp/Screens/Groups/WidgetFollowNew.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiFetchRecommended.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/FetchRecommendedModel.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';

class RecommendedFrind extends StatefulWidget {
  const RecommendedFrind({
    super.key,
  });

  @override
  State<RecommendedFrind> createState() => _RecommendedFrindState();
}

class _RecommendedFrindState extends State<RecommendedFrind> {
  List<FetchRecommendedModel> user = [];
  GetData() {
    ApiFetchRecommended.getUserData(type: 'users').then((value) {
      setState(() {
        user = value.toList();
      });
    });
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  int follow = 0;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'People you may know'.tr,
                  style: SafeGoogleFont(Fonts.font3,
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        user.clear();
                      });
                      GetData();
                    },
                    icon: Icon(Icons.refresh))
              ],
            ),
          ),
          Container(
            width: Get.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user.length == 0
                        ? Row(
                            children: [
                              for (var i = 0; i < 10; i++) LodingWidgetStorye(),
                            ],
                          )
                        : Row(
                            children: [
                              for (var i = 0; i < user.length; i++)
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(ProfileUserScreen(
                                                  avat: user[i].avatar,
                                                  user_id: user[i].user_id,
                                                  cover: user[i].cover,
                                                  name: user[i].name));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                  height: Get.height * 0.20,
                                                  width: Get.width * 0.32,
                                                  fit: BoxFit.cover,
                                                  imageUrl: user[i].avatar),
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Text(
                                            Stringlength(
                                                text: user[i].name, length: 10),
                                            style: SafeGoogleFont(
                                              Fonts.font1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          WidgetFollowNew(
                                              confirm_followers:
                                                  user[i].confirm_followers,
                                              can_follow: '0',
                                              is_following: follow,
                                              user_id: user[i].user_id,
                                              sizew: 0.32),
                                          // SizedBox(
                                          //   height: Get.height * 0.01,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.02,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
        ],
      ),
    );
  }
}
