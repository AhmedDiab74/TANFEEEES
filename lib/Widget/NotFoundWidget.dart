import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';



class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    required this.text,
    super.key,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   images.notFoundSvg,
          // ),
          ///Simple .Lottie Animation
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: Get.width * 0.80,
              child: Text(
                text,
                style: SafeGoogleFont(Fonts.font2,
                    fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
