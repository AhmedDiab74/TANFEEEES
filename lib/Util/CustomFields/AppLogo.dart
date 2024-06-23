import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

AppLogoBar(String title, logo) {
  return AppBar(
    title: logo
        ? Row(children: [
            Image.asset(
              images.logoApar,
              color: Get.isDarkMode ? null : null,
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Text(title,
                style: SafeGoogleFont(Fonts.font3,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Get.isDarkMode ? Colors.white : Colors.black))
          ])
        : Text(title,
            style: SafeGoogleFont(Fonts.font3,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Get.isDarkMode ? Colors.white : Colors.black)),
    elevation: 0,
    centerTitle: false,
    foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
    backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
  );
}
