import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetFellingIcons extends StatelessWidget {
  WidgetFellingIcons({
    required this.text,
    super.key,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (text == 'happy') Iconswowondertimelineflutterapp(text: 'Happy'.tr, icons: '😃'),
        if (text == 'loved') Iconswowondertimelineflutterapp(text: 'Loved'.tr, icons: '🥰'),
        if (text == 'sad') Iconswowondertimelineflutterapp(text: 'Sad'.tr, icons: '😞'),
        if (text == 'so_sad') Iconswowondertimelineflutterapp(text: 'Very Sad'.tr, icons: '😭'),
        if (text == 'angry') Iconswowondertimelineflutterapp(text: 'Angry'.tr, icons: '😡'),
        if (text == 'confused') Iconswowondertimelineflutterapp(text: 'Confused'.tr, icons: '😕'),
        if (text == 'smirk') Iconswowondertimelineflutterapp(text: 'Hot'.tr, icons: '🥵'),
        if (text == 'broke') Iconswowondertimelineflutterapp(text: 'Broken'.tr, icons: '💔'),
        if (text == 'expressionless')
          Iconswowondertimelineflutterapp(text: 'Expressionless'.tr, icons: '😑'),
        if (text == 'cool') Iconswowondertimelineflutterapp(text: 'Cool'.tr, icons: '😎'),
        if (text == 'funny') Iconswowondertimelineflutterapp(text: 'Funny'.tr, icons: '😂'),
        if (text == 'tired') Iconswowondertimelineflutterapp(text: 'Tired'.tr, icons: '😫'),
        if (text == 'lovely') Iconswowondertimelineflutterapp(text: 'Lovely'.tr, icons: '😇'),
        if (text == 'shocked') Iconswowondertimelineflutterapp(text: 'Shocked'.tr, icons: '😵'),
        if (text == 'sleepy') Iconswowondertimelineflutterapp(text: 'Sleepy'.tr, icons: '😴'),
        if (text == 'pretty') Iconswowondertimelineflutterapp(text: 'Pretty'.tr, icons: '🌺'),
        if (text == 'bored') Iconswowondertimelineflutterapp(text: 'Bored'.tr, icons: '🥱'),
      ],
    );
  }
}

class Iconswowondertimelineflutterapp extends StatelessWidget {
  Iconswowondertimelineflutterapp({
    required this.icons,
    super.key,
    required this.text,
  });

  final String text;
  final String icons;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.01,
        ),
        Text(
          'Feeling',
          style: GoogleFonts.cairo(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: Get.width * 0.01,
        ),
        Text(
          icons,
          style: TextStyle(fontSize: 13),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
