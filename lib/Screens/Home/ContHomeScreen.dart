import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Widget/Socket.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPosts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPromoted.dart';
import 'package:wowondertimelineflutterapp/language/settings_controller.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/PostsModel.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/NotificationsApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetUserStories.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetUserStoriesModel.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ContHomeScreen extends GetxController {

  var lastId = '0'.obs;
  RxBool lodingPosts = false.obs;
  RxBool lodingPostsMore = false.obs;
  List<PostModel> data = [];
  List<PostModel> boost = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  RxBool rendome = false.obs;
  GetBoost() async {
    ApiPromoted.Getposts().then((value) {
      boost = value.toList();
      update();
    });
  }

  void onInit() {

    GetPost();
    Story_Theme_Version;
    print('ThamesVersion ' + Story_Theme_Version.toString());

    soketUp();

    meassgesCont();
    GetStories();

    SocketNew.onncteSoket();
    norfiCation();
    // opens();
    soketUp();

    super.onInit();
  }

  GetPost() async {
    lodingPostsSet();
    GetBoost();
    ApiPosts.Getposts('get_news_feed', '').then((value) {
      print('refresh');

      data = value.toList();
      if (value.length - 1 == -1 ? false : lastId.isNotEmpty)
        value.length - 1 == -1
            ? ''
            : lastId.value = value[value.length - 1].post_id;
      if (lastId.isEmpty)
        value.length - 1 == -1
            ? ''
            : lastId.value = value[value.length - 2].post_id;
      print(lastId);
      // ignore: unnecessary_null_comparison

      lodingPostsSet();
      // make your changes here
      update();

      update();
      if (this.isClosed) return;
    });
  }

  bool post = false;
  var tabIndex = 0;

  void onLoding() async {
    lodingPostsMoreSet();
    var list = await ApiPosts.Getposts(lastId.value, tabIndex);
    if (list.length - 1 == -1 ? false : lastId.isNotEmpty)
      list.length - 1 == -1 ? '' : lastId.value = list[list.length - 1].post_id;
    if (lastId.isEmpty)
      list.length - 1 == -1 ? '' : lastId.value = list[list.length - 2].post_id;
    print(lastId);
    rendome.value = true;
    // ignore: unnecessary_null_comparison
    lastId == null ? dispose() : data.addAll(list);

    if (list.length - 1 == -1) {
      post = true;
    } else {
      post = false;
    }
    refreshController.loadComplete();
    lodingPostsMoreSet();
    update();
  }

  void refesh() async {
    boost.clear();
    data.clear();
    // rendome.value = false;

    GetStories();
    GetBoost();

    lodingPostsSet();

    ApiPosts.Getposts('get_news_feed', '').then((value) {
      data = value.toList();
      value.length - 1 == -1
          ? ''
          : lastId.value = value[value.length - 1].post_id;

      lodingPostsSet();
      refreshController.refreshCompleted();
      update();
    });
  }

  void lodingPostsSet() {
    lodingPosts.value = !lodingPosts.value;
    update();
  }

  void lodingPostsMoreSet() {
    lodingPostsMore.value = !lodingPostsMore.value;
  }

  List<GetUserStoriesModel> stor = [];
  bool isLodingStory = true;

  void GetStories() async {
    isLodingStory = await true;
    ApiGetUserStories.getstor().then((value) {
      stor = value.toList();
    });

    fun() {
      var list = ApiGetUserStories.getstor();
      isLodingStory = false;
      if (this.isClosed) return;
      update();
    }
  }

  @override
  void dispose() {
    GetStories();
    super.dispose();
  }

  //notfication count
  var notfi;

  void norfiCation() async {
    Newnotifications_count.Notifications().then((value) {
      notfi = value;
    });
    print('object');
    update();
  }

  var count_new_messagesApi2;

  void meassgesCont() async {
    Count_new_messagesApi.Notifications().then((value) {
      count_new_messagesApi2 = value;
    });
    update();
    var list = await Count_new_messagesApi.Notifications();
  }

  void soketUp() {
    SocketNew.socket.on(
        'new_notification',
        (data) async => {
              await Newnotifications_count.Notifications().then((value) {
                notfi = value;
                print('new_notification: $notfi');
                update();
              }),
            });
    update();
  }

  void AllData() {}
}
