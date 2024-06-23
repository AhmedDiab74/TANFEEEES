import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';

class NoChatScreen extends StatelessWidget {
  const NoChatScreen({
    required this.startChat,
    required this.textData,
    super.key,
  });
  final bool startChat;
  final String textData;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.width * 0.30,
            child: DotLottieLoader.fromAsset("assets/animations/no-data.lottie",
                frameBuilder: (ctx, dotlottie) {
              if (dotlottie != null) {
                return Lottie.memory(dotlottie.animations.values.single);
              } else {
                return Container();
              }
            }),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          if (startChat)
            Text(
              'Welcome! 👋'.tr,
              style: SafeGoogleFont(Fonts.font1,
                  fontSize: 25, color: ColorTheme, fontWeight: FontWeight.bold),
            ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          if (startChat)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Text(
                '${nameApp} connects you with family and friends. Start chatting now!'
                    .tr,
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                  Fonts.font1,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          if (startChat == false)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Text(
                textData,
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                  Fonts.font1,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (startChat)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorTheme, borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                      child: Text(
                    'Start New Chat'.tr,
                    style: SafeGoogleFont(Fonts.font1,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white),
                  )),
                ),
              ),
            )
        ],
      ),
    );
  }
}
