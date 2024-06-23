import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/material.dart';

class FetchReactionMessages extends StatelessWidget {
  const FetchReactionMessages({
    super.key,
    required this.data,
  });

  final data;
//  static String Like = pathReactions + 'like.png';
//   static String Love = pathReactions + 'love.png';
//   static String Haha = pathReactions + 'haha.png';
//   static String Wow = pathReactions + 'wow.png';
//   static String Sad = pathReactions + 'sad.png';
//   static String Angry = pathReactions + 'angry.png';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (data['1'] != null)
          Image.asset(
            images.Like,
            height: Get.height * 0.025,
          ),
        if (data['2'] != null)
          Image.asset(
            images.Love,
            height: Get.height * 0.025,
          ),
        if (data['3'] != null)
          Image.asset(
            images.Haha,
            height: Get.height * 0.025,
          ),
        if (data['4'] != null)
          Image.asset(
            images.Wow,
            height: Get.height * 0.025,
          ),
        if (data['5'] != null)
          Image.asset(
            images.Sad,
            height: Get.height * 0.025,
          ),
        if (data['6'] != null)
          Image.asset(
            images.Angry,
            height: Get.height * 0.025,
          ),
      ],
    );
  }
}
