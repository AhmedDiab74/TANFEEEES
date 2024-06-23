import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';

CustomButton(
  String fieldName,
  controller,
) {
  return Container(
    width: Get.width * 0.4,
    padding: EdgeInsets.symmetric(horizontal: 25.0),
    child: InkWell(
      onTap: controller,
      child: Container(
        decoration: BoxDecoration(
            color: ColorTheme,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: ColorButtonBorder)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(fieldName.tr,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center),
        ),
      ),
    ),
  );
}

class CustomButton2 extends StatelessWidget {
  CustomButton2({
    required this.text,
    this.onTap,
    super.key,
  });

  final String text;
  final onTap;
  @override
  Widget build(BuildContext context) {
// CustomButton2(String fieldName, controller,) {
    return Container(
      width: Get.width * 0.5,
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          decoration: BoxDecoration(
              color: ColorTheme,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: ColorButtonBorder)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(text,
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}

class CustomButtons extends StatelessWidget {
  CustomButtons({
    required this.name,
    this.onTap,
    super.key,
  });

  final String name;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: Get.width * 0.5,
      decoration: BoxDecoration(
          color: ColorTheme,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: ColorButtonBorder)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Text(name.tr,
                  style: GoogleFonts.cairo(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
}
