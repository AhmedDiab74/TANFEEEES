import 'package:get/get.dart';
import '../../ThemesWoWonder.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:quickalert/quickalert.dart';
import 'package:wowondertimelineflutterapp/Widget/NotFoundWidget.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/MorePosts.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/NoChatScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Posts/WidgetPosts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSavedItems.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/PostActionsApi.dart';

class SaveItemsScreen extends StatefulWidget {
  const SaveItemsScreen({Key? key}) : super(key: key);

  @override
  State<SaveItemsScreen> createState() => _SaveItemsScreenState();
}

class _SaveItemsScreenState extends State<SaveItemsScreen> {
  bool lod = false;
  bool nodata = false;
  List<PostModel> data = [];

  void GetPostsSaved() {
    setState(() {
      lod = true;
    });

    ApiSavedItems.Getposts('after_post_id', 'user_id').then((value) => {
          setState(() {
            data = value.toList();
            lod = false;
            value.length > 0 ? '' : nodata = true;
          }),
        });
  }

  @override
  void initState() {
    GetPostsSaved();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        title: Text(
          'Saved Posts'.tr,
        ),
        elevation: 1,
        centerTitle: false,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.white,
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
      ),
      body: lod
          ? LoadingProgressBarr()
          : nodata
              ? Center(
                  child: NotFoundWidget(
                    text: 'There are No Saved Posts'.tr,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < data.length; i++)
                        Column(
                          children: [
                            WidgetPosts(
                              postSticker: data[i].postSticker,
                              postListening: data[i].postListening,
                              postTraveling: data[i].postTraveling,
                              postWatching: data[i].postWatching,
                              postPlaying: data[i].postPlaying,
                              postMap: data[i].postMap,
                              can_not_see_monetized:
                                  data[i].can_not_see_monetized,
                              blog: data[i].blog,
                              voted_id: data[i].voted_id,
                              postFileName: data[i].postFileName,
                              vy_live: data[i].vy_live,
                              blur: data[i].blur,
                              color_id: data[i].color_id,
                              stream_name: data[i].stream_name,
                              headline: data[i].headline,
                              postPrivacy: data[i].postPrivacy,
                              Boosted: false,
                              yout: data[i].postYoutube,
                              shared_info: data[i].shared_info,
                              url_post: data[i].urlsss,
                              trueflasecommet: data[i].comments_status,
                              event: data[i].event,
                              product_id: data[i].product_id,
                              product: data[i].product,
                              more: Container(
                                  child: IconButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          WidgetMorePosts(
                                            url_post: data[i].urlsss,
                                            refreshPost: () {
                                              GetPostsSaved();
                                            },
                                            postText: data[i].postText,
                                            pos: data[i].post_id,
                                            hidePost: () {
                                              setState(() {
                                                data.removeAt(i);
                                              });
                                            },
                                            remove: () {
                                              QuickAlert.show(
                                                onConfirmBtnTap: () {
                                                  PostActionsApi.reaction(
                                                          data[i].post_id,
                                                          'delete')
                                                      .asStream();
                                                  setState(() {
                                                    data.removeAt(i);
                                                  });

                                                  Get.back();
                                                  Get.back();
                                                },
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                text:
                                                    'Do you want to delete the post'
                                                        .tr,
                                                confirmBtnText: 'Yes'.tr,
                                                cancelBtnText: 'No'.tr,
                                                confirmBtnColor: Colors.red,
                                              );
                                            },
                                            adminPost: data[i].admin,
                                            avat: data[i].avatar,
                                            name: data[i].name,
                                            user_id: data[i].user_id,
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.more_vert))),
                              user_id: data[i].user_id,
                              reomvePost: () {
                                setState(() {
                                  data.removeAt(i);
                                });
                              },
                              ad_media: data[i].ad_media,
                              biddingAds: data[i].biddingAds,
                              descriptionAds: data[i].descriptionAds,
                              nameAds: data[i].nameAds,
                              user_dataAds: data[i].user_dataAds,
                              data: data,
                              adminPost: data[i].admin,
                              iint: i,
                              pro_type: data[i].pro_type,
                              is_pro: data[i].is_pro,
                              imReaction: data[i].type,
                              reaction: data[i].reaction,
                              post_id: data[i].post_id,
                              postType: data[i].postType,
                              verified: data[i].verified,
                              postFeeling: data[i].postFeeling,
                              time: data[i].post_time,
                              name: data[i].name,
                              avat: data[i].avatar,
                              postText: data[i].postText,
                              postFile: data[i].postFile,
                              p1080p: data[i].p1080,
                              p2048p: data[i].p2048,
                              p240p: data[i].p240,
                              p360p: data[i].p360,
                              p4096p: data[i].p4096,
                              p480p: data[i].p480,
                              p720p: data[i].p720,
                              options: data[i].options,
                              postRecord: data[i].postRecord,
                              contLike: data[i].reaction,
                              contcoment: int.parse(data[i].post_comments),
                              post_share: int.parse(data[i].post_share),
                              islike: data[i].reaction1,
                              photoMulti2: data[i].photoMulti2,
                              photo_album: data[i].photo_album,
                              postimage: data[i].postFile,
                              type: data[i].type,
                              page_id: data[i].page_id,
                              group_id: data[i].group_id,
                              avatar_group: data[i].avatargroupe,
                              name_group: data[i].group_title,
                              cover: data[i].cover,
                              comment_cont: data[i].comments_status,
                            ),
                            Container(
                              width: Get.width,
                              color: Colors.white,
                              height: Get.height * 0.01,
                            )
                          ],
                        ),
                    ],
                  ),
                ),
    );
  }
}
