import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Colors2.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';

const Color backRoundColorSearch = Color(0xffF8F9FD);
const Color backRoundColorSearchDark = Color.fromARGB(255, 0, 0, 0);
const Color TrueFalseOrangeColor = Color.fromRGBO(255, 77, 45, 1);

// const Color ColorThemeDark = Color(0xff036451);
// const Color ColorThemeOpacity = Color(0x5267ead4);
// const Color ColorButtonBorder = Color(0xFF7cfce8);



const Color ColorBackIcons = Color(0xfff6f6f6);
const Color ColorsContainer = Colors.white;
const Color scaffoldBackgroundColorLight = Color.fromARGB(255, 255, 255, 255);

/// Dark Theme
const Color ColorDarkBackground = Color(0xff1E252B);
const Color ColorDarkComponents = Color(0xff38404b);
const Color ColorDarkTextBox = Color(0xff2b3843);

Color BodyBackground = Get.isDarkMode ? ColorDarkBackground : Colors.white;
Color ComponentBackground = Get.isDarkMode ? ColorDarkComponents : Colors.white;

Color AppBarBackground = Get.isDarkMode ? ColorDarkComponents : Colors.white;

LinearGradient linearGradientBoxMore = LinearGradient(
    colors: [
      Color.fromARGB(255, 161, 246, 233),
      Color.fromARGB(255, 70, 215, 193),
    ],
    begin: Alignment.topLeft, //begin of the gradient color
    end: Alignment.bottomRight, //end of the gradient color
    stops: [0, 0.8] //stops for individual color
    //set the stops number equal to numbers of color
    );

Color scaffoldBackgroundColorChatGpt = const Color(0xFF343541);
Color cardColorGpt = const Color(0xFF444654);

///////
class Fonts {
  //Urbanist //Fonts.font3//SF Pro Display
  static String font1 = 'Urbanist';
  static String font2 = 'Manrope';
  static String font3 = 'Urbanist';
  // static String font4 = Fonts.font1;
}




final ColorTheme = ColorTheme2;
// final ColorTheme = Get.isDarkMode
//     ? Color(int.parse(
//     GetSetList[0]['btn_hover_background_color'].replaceAll('#', '0xff')))
//     : Color(int.parse(
//     GetSetList[0]['btn_background_color'].replaceAll('#', '0xff')));
final ColorThemeDark =
Color(int.parse(GetSetList[0]['btn_disabled'].replaceAll('#', '0xff')));
final ColorThemeOpacity = Color(
    int.parse(GetSetList[0]['btn_background_color'].replaceAll('#', '0x52')));
final ColorButtonBorder = Color(int.parse(
    GetSetList[0]['btn_hover_background_color'].replaceAll('#', '0xff')));