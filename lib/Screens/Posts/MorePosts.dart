import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Share/WidgetShare.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiHidePost.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiBlockUser.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiEditPosts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetPostDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/AddFriendScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPostDataModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserDataModel.dart';

class WidgetMorePosts extends StatefulWidget {
  WidgetMorePosts({
    super.key,
    required this.avat,
    required this.name,
    required this.user_id,
    required this.adminPost,
    required this.remove,
    required this.hidePost,
    required this.pos,
    required this.postText,
    required this.refreshPost,
    required this.url_post,
  });

  final String avat;
  final String name;
  final String user_id;
  final adminPost;
  final remove;
  final hidePost;
  String url_post;
  String postText;
  String pos;
  final refreshPost;

  @override
  State<WidgetMorePosts> createState() => _WidgetMorePostsState();
}

class _WidgetMorePostsState extends State<WidgetMorePosts> {
  List<GetUserDataModel> followdata = [];
  bool follow = false;
  bool save = false;

  void GetData() async {
    await GetUserDataApi.getUserData(widget.user_id).then((value) {
      setState(() {
        followdata = value.toList();
        if (value[value.length - 1].is_following == 1) {
          follow = true;
        }
      });
    });
  }

  @override
  void initState() {
    GetData();
    GetPostdataa();
    super.initState();
  }

  bool lod = false;
  List<GetPostDataModel> data = [];

  void GetPostdataa() {
    setState(() {
      lod = true;
    });
    GetPostDataApi.GetPostsData(widget.pos).then((value) {
      setState(() {
        data = value.toList();
        lod = false;
      });
    });
  }

  final TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // height: widget.adminPost ? Get.height * 0.40 : Get.height * 0.50,
      decoration: BoxDecoration(
          color: Get.isDarkMode ? ColorDarkBackground : Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
        child: widget.adminPost

////my Post
            ? lod
                ? LoadingProgressBarr()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: Get.width * 0.20,
                            height: 4,
                            color: Color(0xffE2E8F0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'More Options'.tr,
                            style: SafeGoogleFont(Fonts.font2,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                // color: Get.isDarkMode
                                //     ? ColorDarkComponents
                                //     : Colors.grey[300],
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(children: [
                              Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      text.text = widget.postText;
                                    });
                                    Get.dialog(Column(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                width: Get.width,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Scaffold(
                                                      appBar: AppBar(
                                                        elevation: 0,
                                                        foregroundColor:
                                                            Get.isDarkMode
                                                                ? Colors.white
                                                                : ColorTheme,
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .scaffoldBackgroundColor,
                                                        title: Text(
                                                            'Edit Post'.tr),
                                                      ),
                                                      body: Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5),
                                                            width: Get.width,
                                                            height: Get.height *
                                                                0.40,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1)),
                                                            child: TextField(
                                                              controller: text,
                                                              decoration: InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              maxLines: null,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.30,
                                                                  height:
                                                                      Get.height *
                                                                          0.05,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          ColorTheme,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    'Cancel'.tr,
                                                                    style: SafeGoogleFont(
                                                                        Fonts
                                                                            .font1,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  var edite =
                                                                      await ApiEditePosts.create(
                                                                          widget
                                                                              .pos,
                                                                          text.text);
                                                                  print(edite);
                                                                  if (edite[
                                                                          'action'] ==
                                                                      'edite') {
                                                                    await widget
                                                                        .refreshPost();

                                                                    Get.back();
                                                                    Get.back();
                                                                    Get.snackbar(
                                                                        'Edit Post'
                                                                            .tr,
                                                                        'Post edit Succeeded'
                                                                            .tr);
                                                                  } else {
                                                                    Get.back();
                                                                    Get.back();
                                                                    Get.snackbar(
                                                                        'Edit Post'
                                                                            .tr,
                                                                        'The post change did not work'
                                                                            .tr);
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.30,
                                                                  height:
                                                                      Get.height *
                                                                          0.05,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          ColorTheme,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    'Save'.tr,
                                                                    style: SafeGoogleFont(
                                                                        Fonts
                                                                            .font1,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                                  },
                                  child: WidgetMoreOprions(
                                    images: images.EdtiPost,
                                    name: 'Edit Post'.tr,
                                    smallText: 'Edit Post information'.tr,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                    Get.bottomSheet(WidgetShare(
                                      url_post: widget.url_post,
                                      postid: widget.pos,
                                    ));
                                  },
                                  child: WidgetMoreOprions(
                                    images: images.MoreOptionsLink,
                                    name: 'Share'.tr,
                                    smallText:
                                        'Share this post with your friends'.tr,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    widget.remove();
                                  },
                                  child: WidgetMoreOprions(
                                    images: images.reomve,
                                    name: 'Remove'.tr,
                                    smallText:
                                        'Delete this post completely..'.tr,
                                  ),
                                ),
                              ),
                              for (var i = 0; i < data.length; i++)
                                Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      PostActionsApi.reaction(
                                          widget.pos, 'disable_comments');

                                      Get.back();
                                    },
                                    child: WidgetMoreOprions(
                                      images: images.disableComment,
                                      name: data[i].comments_status == '0'
                                          ? 'Enable comments'.tr
                                          : 'Disable comments'.tr,
                                      smallText: data[i].comments_status == '0'
                                          ? 'Allow Members to comment on this post'
                                              .tr
                                          : 'Disallow Members to comment on this post'
                                              .tr,
                                    ),
                                  ),
                                ),
                            ])),
                      ],
                    ),
                  )

//my Post
            :

            //user Post
            SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: Get.width * 0.20,
                        height: 4,
                        color: Color(0xffE2E8F0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        'More Options'.tr,
                        style: SafeGoogleFont(Fonts.font2,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: Get.isDarkMode
                                ? ColorDarkComponents
                                : Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                                Get.bottomSheet(WidgetShare(
                                  url_post: widget.url_post,
                                  postid: widget.pos,
                                ));
                              },
                              child: WidgetMoreOprions(
                                images: images.MoreOptionsLink,
                                name: 'Share'.tr,
                                smallText:
                                    'Share this post with your friends'.tr,
                              ),
                            ),
                          ),

                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                Get.back();
                                var bloc = await ApiBlockUnBlockUser.blcked(
                                    widget.user_id, 'block');

                                if (bloc['api_status'] == 200) {
                                  if (bloc['block_status'] == 'invalid') {
                                    Get.snackbar('Banned'.tr,
                                        'This user cannot be banned'.tr);
                                  } else {
                                    Get.snackbar(
                                        'BanUser', bloc['block_status']);
                                    widget.hidePost();
                                  }
                                }
                              },
                              child: WidgetMoreOprions(
                                images: images.block,
                                name: 'Block'.tr,
                                smallText:
                                    'Block this User, You won\'t be able see their posts'
                                        .tr,
                              ),
                            ),
                          ),

                          save
                              ? Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        PostActionsApi.reaction(
                                            widget.pos, 'save');
                                        save = !save;
                                      });
                                    },
                                    child: WidgetMoreOprionsCansele(
                                      images: images.SavePostsImage,
                                      name: 'Unsaved Post'.tr,
                                      smallText:
                                          'Remove this post to your favorite list.'
                                              .tr,
                                    ),
                                  ))
                              : Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        PostActionsApi.reaction(
                                            widget.pos, 'save');
                                        save = !save;
                                      });
                                    },
                                    child: WidgetMoreOprions(
                                      images: images.SavePostsImage,
                                      name: 'Save Post'.tr,
                                      smallText:
                                          'Add this post to your favorite list.'
                                              .tr,
                                    ),
                                  ),
                                ),
                          // Container(
                          //   margin: EdgeInsets.symmetric(horizontal: 20),
                          //   color: Colors.grey.withOpacity(0.3),
                          //   height: 1,
                          // ),
                          // if (widget.adminPost == false)
                          //   WidgetMoreOprions(
                          //     images: images.msg,
                          //     name: 'Message'.tr,
                          //     smallText: 'Send this Post to your friends'.tr,
                          //   ),
                        ])),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? ColorDarkComponents
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          if (widget.adminPost == false)
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  widget.hidePost();
                                  HidePostApi.hidepost(widget.pos);
                                  Get.back();
                                },
                                child: WidgetMoreOprions(
                                  images: images.Eyeslash,
                                  name: 'Hide the post'.tr,
                                  smallText:
                                      'I don\'t want to see this post anymore'
                                          .tr,
                                ),
                              ),
                            ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                PostActionsApi.reaction(widget.pos, 'report');
                                Get.back();
                              },
                              child: WidgetMoreOprions(
                                images: images.infocircle,
                                name: 'Report the post'.tr,
                                smallText: 'Report this post to us.'.tr,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class MyPostsMore extends StatelessWidget {
  const MyPostsMore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [BoxShadow(blurRadius: 1, color: Colors.black)]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Icon(
                  Icons.edit_note,
                  weight: 30,
                )),
              ),
            ),
            SizedBox(
              width: Get.width * 0.01,
            ),
            Text(
              'Edit Post'.tr,
              style: SafeGoogleFont(Fonts.font1,
                  fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Divider(),
      ],
    );
  }
}

class WidgetMoreOprions extends StatelessWidget {
  WidgetMoreOprions({
    required this.images,
    required this.name,
    required this.smallText,
    super.key,
  });

  String images;
  String name;
  String smallText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.0),
      // margin: EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color:
        //     Get.isDarkMode ? Color.fromARGB(44, 210, 202, 202) : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              // color: Get.isDarkMode
              //     ? Color.fromARGB(44, 210, 202, 202)
              //     : ColorBackIcons,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Image.asset(
              images,
              color: Get.isDarkMode ? Colors.white : null,
              width: 20,
              height: 20,
            ),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.tr,
                style: SafeGoogleFont(Fonts.font2,
                    fontWeight: FontWeight.w700,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 13),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
              ),
              Container(
                width: Get.width * 0.75,
                child: Text(
                  smallText.tr,
                  style: SafeGoogleFont(
                    Fonts.font2,
                    fontSize: 12,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: true,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class WidgetMoreOprionsCansele extends StatelessWidget {
  WidgetMoreOprionsCansele({
    required this.images,
    required this.name,
    required this.smallText,
    super.key,
  });

  String images;
  String name;
  String smallText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color:
        //     Get.isDarkMode ? Color.fromARGB(44, 210, 202, 202) : Colors.white,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              // color: Get.isDarkMode
              //     ? Color.fromARGB(44, 210, 202, 202)
              //     : ColorBackIcons,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Image.asset(
              images,
              color: Get.isDarkMode ? Colors.white : null,
              width: 20,
              height: 20,
            ),
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.tr,
                style: SafeGoogleFont(
                  Fonts.font2,
                  fontWeight: FontWeight.w700,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Text(
                smallText.tr,
                style: SafeGoogleFont(
                  Fonts.font2,
                  fontSize: 12,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
