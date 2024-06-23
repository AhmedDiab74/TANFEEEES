import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Widget/WidgetAudio.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/VideoListChat.dart';
import 'package:wowondertimelineflutterapp/Screens/Chat/FetchReactionMessages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetAllMesageModel.dart';

class WidgetReplayMessages extends StatefulWidget {
  WidgetReplayMessages({super.key, required this.replaydata});
  final replaydata;

  @override
  State<WidgetReplayMessages> createState() => _WidgetReplayMessagesState();
}

class _WidgetReplayMessagesState extends State<WidgetReplayMessages> {
  Widget build(BuildContext context) {
    final data = widget.replaydata;
    return Container(
      width: data['text'].length > 40 ? Get.width * 0.66 : null,
      decoration: BoxDecoration(
          color: widget.replaydata['type'] == 'left_text'
              ? Color.fromARGB(74, 158, 158, 158)
              : Color.fromARGB(141, 0, 0, 0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Text(
            //   'Reply:',
            //   style: SafeGoogleFont(Fonts.font1,
            //       fontWeight: FontWeight.bold, color: Colors.white),
            // ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          data['media'].toString().isImageFileName ? 8 : 20,
                      vertical:
                          data['media'].toString().isImageFileName ? 8 : 10),
                  child: Column(
                    children: [
                      data['media'].toString().isImageFileName
                          ? SizedBox()
                          : Container(
                              width: data['text'].toString().length > 40
                                  ? Get.width * 0.50
                                  : null,
                              child: Text(
                                Stringlength(
                                    text: ReplaceCharacter(
                                        data['text'].toString()),
                                    length: 250),
                                style: SafeGoogleFont(
                                  Fonts.font1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                                maxLines: 3,
                              ),
                            ),
                      if (data['media'].toString().isImageFileName)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: data['media'].toString(),
                            fit: BoxFit.cover,
                            width: Get.width * 0.40,
                          ),
                        ),
                      if (data['media'].toString().isAudioFileName)
                        WidgetSond(postRecord: data['media'].toString()),
                      if (data['media'].toString().isVideoFileName)
                        Container(
                          width: Get.width * 0.50,
                          height: Get.height * 0.30,
                          child: VideoListChat2(
                            video: data['media'].toString(),
                            looping: false,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
