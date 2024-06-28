import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Screens/ChatGPTScreen/page/HomePage.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/HomePagesScreen.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetMyPage.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiLikePage.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';

class LikedPages extends StatefulWidget {
  const LikedPages({super.key});

  @override
  State<LikedPages> createState() => _LikedPagesState();
}

class _LikedPagesState extends State<LikedPages> {
  bool loding = false;
  Lodings(lod) {
    setState(() {
      loding = lod;
    });
  }

  bool nodata = false;

  nodatas(lod) {
    setState(() {
      nodata = lod;
    });
  }

  String lastId = '0';
  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  List<GetPagesDataModel> mypage = [];

  void getData() async {
    Lodings(true);

    ApiGetAllMyPage.mypage('0').then((value) {
      setState(() {
        Lodings(false);
        if (value.length == 0) {
          nodatas(true);
        }
        mypage = value.toList();
        lastId = value[value.length - 1].page_id;
      });
    });
  }

  void onLoding() async {
    // await Future.delayed(Duration(seconds: 3));
    var list = await ApiGetAllMyPage.mypage(lastId);

    // print('onLoding');
    // print(lastId);
    // print(list.length - 1);
    list.length - 1 == -1 ? '' : lastId = list[list.length - 1].page_id;

    // if (list.length - 1 == -1) {
    //   post = true;
    // } else {
    //   post = false;
    // }
    setState(() {
      refreshController.loadComplete();
      lastId == null ? dispose() : mypage.addAll(list);
    });
  }

  void onRefresh() async {
    var list = await ApiGetAllMyPage.mypage('0');

    setState(() {
      mypage.clear();
      mypage.addAll(list.toList());

      refreshController.refreshCompleted();

      lastId = mypage[mypage.length - 1].page_id;
    });
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SmartRefresher(
        onLoading: onLoding,
        onRefresh: onRefresh,
        enablePullDown: true,
        enablePullUp: true,
        controller: refreshController,
        child: loding
            ? Center(
          child: CircularProgressIndicator(),
        )
            : nodata
            ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    'assets/animations/serach.json',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: sizedHeight(context) * 0.1,
                ),
                Text(
                  'You haven\'t liked any page',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: sizedHeight(context) * 0.1,
                ),
              ],
            ))
        // ? Center(
        //     child: NoChatScreen(
        //     startChat: false,
        //     textData: 'You are not subscribed to any channel'.tr,
        //   ))
            : SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < mypage.length; i++)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(HomePageScreen(
                                  page_id: mypage[i].page_id));
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      height: 70,
                                      width: 70,
                                      imageUrl: mypage[i].avatar),
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
                                    Text(
                                      mypage[i].page_title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.004,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        Text(
                                          '${mypage[i].likes} People like this',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.004,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        Text(
                                          mypage[i].category,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ApiLikePage.like(mypage[i].page_id);

                              setState(() {
                                mypage.removeAt(i);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorTheme,
                                borderRadius:
                                BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.1,
                                    vertical: 10),
                                child: Text(
                                  'Liked',
                                  style:
                                  TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(60, 0, 0, 0),
                      height: 0.1,
                      width: Get.width,
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
