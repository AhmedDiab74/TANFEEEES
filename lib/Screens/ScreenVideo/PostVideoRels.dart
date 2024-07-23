import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Screens/ScreenVideo/VideoEditor.dart';
import 'package:wowondertimelineflutterapp/Screens/ScreenVideo/VideoPlayerCached.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiAddViewPost.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:like_button/like_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Share/WidgetShare.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiReaction.dart';
import 'package:wowondertimelineflutterapp/Screens/Comment/CommentScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/postYoutubeScree.dart';
import 'package:wowondertimelineflutterapp/Screens/ScreenVideo/PostsVideoCont.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String likeText = 'like2';
  int initialPage = 0;
  int contt = 0;
  final ImagePicker _picker = ImagePicker();
  void _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);

    if (mounted && file != null) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => VideoEditor(file: File(file.path)),
        ),
      );
    }
  }
  @override
  void initState() {
    Get.put(PostsVideoCont());
    super.initState();
  }

  bool didDispose = false;

  void dispose() {
    didDispose = true;
    super.dispose();
  }

  void safeSetState(VoidCallback callback) {
    if (!didDispose) {
      setState(callback);
    }
  }

  Widget build(BuildContext context) {
    final cont = Get.put(PostsVideoCont());
    return SafeArea(
        child: Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
                backgroundColor: ColorDarkComponents,
                body: Obx(
                  () {
                    return SmartRefresher(
                      controller: cont.refreshController,
                      child: PageView.builder(
                          onPageChanged: (val) async {
                            cont.ComeentUpdate(val);
                            cont.onLoding();
                            await [
                              if (val == 0)
                                {
                                  cont.onRefresh(),
                                  setState(() {
                                    val = 0;
                                  }),
                                }
                            ];

                            ApiAddViewsVideo.add(cont.data[val].post_id);
                          },
                          controller: PageController(
                            initialPage: initialPage,
                            keepPage: false,
                            viewportFraction: 1,
                          ),
                          itemCount: cont.data.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            return Stack(
                              textDirection: TextDirection.ltr,
                              children: [
                                Center(
                                    child: VideoPlayerCached(
                                  imageTemp: cont.data[index].postFileThumb,
                                  urls: cont.data[index].postFile,
                                )),
                                Positioned(
                                  bottom: Get.height * 0.08,
                                  child: Container(
                                    width: Get.width * 0.70,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // Get.toNamed(Routes.profileUserScreen,
                                              //     arguments: ({
                                              //       'user_id':
                                              //           cont.data[index].user_id,
                                              //       'avatar':
                                              //           cont.data[index].avatar,
                                              //       'cover': cont.data[index].cover,
                                              //     }));
                                            },
                                            child: CircleAvatar(
                                              maxRadius: 20,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      cont.data[index].avatar),
                                            ),
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
                                                cont.data[index].name,
                                                style: GoogleFonts.cairo(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: Get.height * 0.1,
                                  right: 20,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Column(
                                      children: [
                                        LikeWidget(
                                          count: cont.data[index].reaction,
                                          post_id: cont.data[index].post_id,
                                          likeUpdite: () {
                                            cont.LikeIndex(index);
                                          },
                                          is_reacted:
                                              cont.data[index].is_reacted,
                                        ),

                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),

                                        InkWell(
                                          onTap: () {
                                            Get.dialog(CommentScreen(
                                              fetch_comments: 'fetch_comments',
                                              trueflasecommet: cont
                                                  .data[index].trueflasecommet,
                                              post_id: cont.data[index].post_id,
                                              contcoment: () {
                                                setState(() {
                                                  cont.commentPlus(index);
                                                });
                                              },
                                            ));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(198, 17, 17, 17),
                                            child: Image.asset(
                                              images.RellsComment,
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Text(
                                          cont.commentsCount.value.toString(),
                                          style: GoogleFonts.cabinCondensed(
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        // share-arrow-svgrepo-com.svg
                                        InkWell(
                                          onTap: () {
                                            Get.bottomSheet(WidgetShare(
                                                postid:
                                                    cont.data[index].post_id,
                                                url_post:
                                                    cont.data[index].urlsss));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                Color.fromARGB(198, 17, 17, 17),
                                            child: Image.asset(
                                              images.shareRels,
                                              height: 30,
                                              width: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            var data = cont.data[index];
                                            Get.bottomSheet(WidgetMorePosts(
                                              adminPost: cont.data[index].admin,
                                              avat: data.avatar,
                                              hidePost: () {
                                                setState(() {
                                                  cont.data.remove(index);
                                                });
                                              },
                                              name: data.name,
                                              pos: data.post_id,
                                              postText: data.postText,
                                              refreshPost: null,
                                              remove: () {
                                                setState(() {
                                                  cont.data.remove(index);
                                                });
                                              },
                                              url_post: data.urlsss,
                                              user_id: data.user_id,
                                            ));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        198, 17, 17, 17),
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.more_vert,
                                                  color: Colors.white,
                                                  size: 30,
                                                )),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'More'.tr,
                                                  style: SafeGoogleFont(
                                                      Fonts.font2,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: Get.height * 0.04,
                                  child: Container(
                                    width: Get.width * 0.95,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            Icons.arrow_back_ios_new,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Reels'.tr,
                                            style: SafeGoogleFont(Fonts.font2,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          InkWell(
                                            onTap:_pickVideo,
                                            child: CircleAvatar(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              backgroundColor: Colors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })),
                    );
                  },
                ))));
  }
}

class LikeWidget extends StatefulWidget {
  LikeWidget({
    required this.count,
    super.key,
    required this.post_id,
    required this.is_reacted,
    required this.likeUpdite,
  });

  int count;
  bool is_reacted;
  String post_id;
  final likeUpdite;

  @override
  State<LikeWidget> createState() => _LikeWidgetState();
}

class _LikeWidgetState extends State<LikeWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.is_reacted) {
          setState(() {
            widget.count--;
          });

          ApiPostReaction.postReaction(widget.post_id, 'reaction', '0');
        } else {
          setState(() {
            widget.count++;
          });
        }

        widget.is_reacted = !widget.is_reacted;
        widget.likeUpdite();
      },
      child: Column(
        children: [
          // Container(child: Likesss()),
          Icon(
            Icons.thumb_up,
            color: widget.is_reacted
                ? const Color.fromARGB(255, 3, 55, 98)
                : Colors.white,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            widget.count.toString(),
            style: GoogleFonts.cabinCondensed(color: Colors.white),
          ),
        ],
      ),
    );
  }

  // Widget Likesss() {
  //   return LikeButton(
  //       size: 30,
  //       circleColor:
  //           CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
  //       likeBuilder: (bool isLiked) {
  //         return Image.asset(
  //           'assets/images/Path 9.png',
  //           width: 30,
  //           height: 30,
  //           color: isLiked ? null : Colors.white,
  //         );
  //       },
  //       // likeCount: 665,
  //       countBuilder: (count, isLiked, text) {
  //         var color = isLiked ? Colors.red : Colors.grey;
  //         Widget result;
  //         if (count == 0) {
  //           result = Text(
  //             "love",
  //             style: TextStyle(color: color),
  //           );
  //         } else
  //           result = Text(
  //             text,
  //             style: TextStyle(color: color),
  //           );
  //         return result;
  //       });
  // }
}
