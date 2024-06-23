import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/FriendsApi.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GetUserMessageScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllFriendsModel.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/GetSingleUserMessageScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';

class AddMemberChat extends StatefulWidget {
  AddMemberChat({
    super.key,
    required this.getData,
  });
  final getData;
  @override
  State<AddMemberChat> createState() => AddMemberChatState();
}

class AddMemberChatState extends State<AddMemberChat> {
  bool led = true;
  List<GetAllFrindsModel> data = [];
  String userid = '0';
  GetAllFrind() async {
    FriendsApi.allFrinds('', '', userid).then((ameen) {
      setState(() {
        data = ameen.toList();
        led = false;
        userid = data[data.length - 1].user_id;
      });
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void refesh() async {
    setState(() {
      data.clear();
    });

    FriendsApi.allFrinds('', '', userid).then((value) {
      setState(() {
        data = value.toList();
        value.length - 1 == -1 ? '' : userid = value[value.length - 1].user_id;

        _refreshController.refreshCompleted();
      });
    });
  }

  void onLoding() async {
    var list = await FriendsApi.allFrinds('', '', userid);
    if (list.length - 1 == -1 ? false : userid.isNotEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 1].user_id;
    if (userid.isEmpty)
      list.length - 1 == -1 ? '' : userid = list[list.length - 2].user_id;
    print(userid);
    // ignore: unnecessary_null_comparison
    userid == null ? dispose() : data.addAll(list);

    _refreshController.loadComplete();

    setState(() {});
  }

  @override
  void initState() {
    GetAllFrind();
    super.initState();
  }

  XFile? ImagePost;
  String? filename;

  TextEditingController grou_name = TextEditingController();
  List<String> mempers = [];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Send Messages'.tr),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * 0.85,
                  child: SmartRefresher(
                    onRefresh: refesh,
                    onLoading: onLoding,
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshController,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        for (var i = 0; i < data.length; i++)
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                  Get.to(GetSingleUserMessageScreen(
                                    avat: data[i].avatar,
                                    userid: data[i].user_id,
                                    username: data[i].username,
                                    name: data[i].name,
                                    color: GetSetList[0]
                                        ['btn_background_color'],
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 25,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  data[i].avatar),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.02,
                                        ),
                                        Text(Stringlength(
                                            text: data[i].name, length: 25)),
                                      ],
                                    ),
                                    Container(
                                      color: Get.isDarkMode
                                          ? NavBarColorDark
                                          : ColorTheme,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 3),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
