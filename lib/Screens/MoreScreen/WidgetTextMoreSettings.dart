import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetTextMoreSetetings extends StatelessWidget {
  WidgetTextMoreSetetings({
    required this.ontap,
    required this.text,
    required this.svg,
    super.key,
  });

  String text;
  String svg;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.symmetric(vertical:4),
        child: Material(
      color: Get.isDarkMode ? ColorDarkComponents : Colors.transparent,
      child: InkWell(
        onTap: ontap,
        child: Container(
          //Adjust as necessary
          // margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
          //Adjust as necessary
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            // color:
            // Get.isDarkMode ? ColorDarkComponents : Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: Get.width * 0.07,
                        width: Get.width * 0.07,
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          // color: Get.isDarkMode
                          //     ? Color.fromARGB(44, 210, 202, 202)
                          //     : ColorBackIcons,

                          borderRadius: BorderRadius.circular(
                              10.0), //Adjust the radius as necessary
                        ),
                        child: SvgPicture.asset(
                          svg,
                          height: Get.height * 0.014,
                          width: Get.width * 0.014,
                          color: ColorTheme,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Text(
                        text,
                        style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    ));
  }
}
