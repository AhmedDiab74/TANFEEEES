import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';

class ChatBackgroundScreen extends StatelessWidget {
  const ChatBackgroundScreen({
    Key? key,
    required this.update,
    required this.user_id,
  }) : super(key: key);
  final String user_id;
  final update;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        title: Text('Chat Background'.tr),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          WidgetImages(
            images: ChatBackground.back0,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back1,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back2,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back3,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back4,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back5,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back6,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back7,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back8,
            user_id: user_id,
            update: update,
          ),
          WidgetImages(
            images: ChatBackground.back9,
            user_id: user_id,
            update: update,
          ),
        ],
      ),
    );
  }
}

class WidgetImages extends StatelessWidget {
  const WidgetImages({
    super.key,
    required this.images,
    required this.user_id,
    required this.update,
  });
  final String images;
  final String user_id;
  final update;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.dialog(Scaffold(
          appBar: AppBar(
            actions: [
              InkWell(
                onTap: () async {
                  await SharedP.Save('chat$user_id', images);
                  Get.back();
                  Get.back();
                  Get.back();
                  update();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Center(child: Text('Save')),
                    ),
                  ),
                ),
              )
            ],
            backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
          ),
          body: Container(
            width: Get.width,
            height: Get.height,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(images),
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.9), BlendMode.dstATop),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0))),
              width: Get.width,
            ),
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          images,
          width: Get.width,
          height: Get.height * 0.80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
