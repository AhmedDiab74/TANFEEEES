import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';

class NoResultsFoundScreen extends StatelessWidget {
  const NoResultsFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Get.height * 0.20,
        ),
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
        Text(
          'No Results Found'.tr,
          style: SafeGoogleFont(Fonts.font1,
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     'Please make sure it is written correctly.'.tr,
        //     style: SafeGoogleFont(Fonts.font1,
        //         fontSize: 13,),
        //   ),
        // ),
      ],
    );
  }
}
