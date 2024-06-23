import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowondertimelineflutterapp/Util/DetectbaleText.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/GetUserDataApi.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetColorPost.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetColorPostModel.dart';
import 'package:wowondertimelineflutterapp/Screens/HashtagPosts/HashtagPostsScreen.dart';

import 'package:wowondertimelineflutterapp/Screens/ProfileUserScreen/ProfileUserScreen.dart';
import 'package:flutter_social_textfield/util/regular_expressions.dart';
import 'package:wowondertimelineflutterapp/Util/deetion.dart';

class ColorPosts extends StatefulWidget {
  const ColorPosts({
    super.key,
    required this.postText,
    required this.color_id,
  });
  final String postText;
  final String color_id;
  @override
  State<ColorPosts> createState() => _ColorPostsState();
}

class _ColorPostsState extends State<ColorPosts> {
  bool hasHashTags(String value) {
    final decoratedTextColor = Colors.blue;
    final detector = Detector(
        textStyle: TextStyle(),
        detectedStyle: TextStyle(color: decoratedTextColor),
        detectionRegExp: RegExp(''));
    final result = detector.getDetections(value);
    final detections = result
        .where((detection) => detection.style!.color == decoratedTextColor)
        .toList();
    return detections.isNotEmpty;
  }

  List<GetColorPostModel> data = [];

  getColor() async {
    await ApiGetColorPost.color(widget.color_id).then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  @override
  void initState() {
    getColor();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < data.length; i++)
                Container(
                  decoration: BoxDecoration(
                      image: data[i].image.toString().isNotEmpty
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(data[i].image),
                              fit: BoxFit.cover)
                          : null,
                      gradient: data[i].color_2.toString().isNotEmpty
                          ? LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                // Color(),
                                Color(int.parse(data[i]
                                    .color_1
                                    .toString()
                                    .replaceAll('#', '0xff'))),

                                Color(int.parse(data[i]
                                    .color_2
                                    .toString()
                                    .replaceAll('#', '0xff'))),
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(0)),
                  width: Get.width,
                  height: Get.height * 0.40,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Tooltip(
                            preferBelow: true,
                            message: 'Copy'.tr,
                            onTriggered: () {
                              Clipboard.setData(
                                  new ClipboardData(text: widget.postText));
                            },
                            child: DetectableText(
                              trimCollapsedText: '\n' + 'See More'.tr + '...',
                              trimExpandedText: '\n' + 'Show less'.tr,
                              moreStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              lessStyle: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              // trimExpandedText: 'show less'.tr,
                              // trimCollapsedText: 'read more'.tr,
                              text: ReplaceCharacter(widget.postText),
                              trimLines: 4,
                              basicStyle: GoogleFonts.cairo(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(int.parse(data[0]
                                      .text_color
                                      .toString()
                                      .replaceAll('#', '0xff')))),
                              onTap: (tappedText) async {
                                if (hasHashTags(tappedText)) {
                                  Get.to(HashtagPostsScreen(
                                    titel: tappedText,
                                  ));
                                }
                                ;

                                RegExp exp = RegExp(
                                    "([@]([$detectionContentLetters]+))|$urlRegexContent",
                                    multiLine: true);

                                Iterable<RegExpMatch> matches =
                                    exp.allMatches(widget.postText);
                                for (final m in matches) {
                                  if (m[0].toString().isNotEmpty) {
                                    var username =
                                        await GetUserDataUserName.getUserData(
                                            m[0]
                                                .toString()
                                                .replaceAll('@', ''));
                                    if (username != null) {
                                      Get.to(ProfileUserScreen(
                                          avat: username['avatar'],
                                          user_id: username['user_id'],
                                          cover: username['cover'],
                                          name: username['name']));
                                    } else {
                                      UrlGo(m[0].toString());
                                    }
                                  }
                                }
                              },
                              detectionRegExp: RegExp(
                                "(?!\\n)(?:^|\\s)([#@]([$detectionContentLetters]+))|$urlRegexContent",
                                multiLine: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
