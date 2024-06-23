import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

class ScaffoldWidget extends StatefulWidget {
  ScaffoldWidget(
      {super.key,
      required this.AppBarTrueOrFalse,
      required this.title,
      required this.body,
      required this.centerTitle,
      required this.elevation,
      required this.loding});
  final Widget body;
  final bool centerTitle;
  final double elevation;
  final String title;
  final bool loding;
  final bool AppBarTrueOrFalse;
  @override
  State<ScaffoldWidget> createState() => _ScaffoldWidgetState();
}

AnimationBehavior animationBehavior = AnimationBehavior.preserve;

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: widget.loding,
      blurEffectIntensity: 4,
      progressIndicator: SpinKitFadingCircle(
        color: ColorTheme,
        size: 90.0,
      ),
      dismissible: false,
      opacity: 0.4,
      child: Scaffold(
          backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
          appBar: widget.AppBarTrueOrFalse
              ? AppBar(
                  centerTitle: widget.centerTitle,
                  elevation: widget.elevation,
                  backgroundColor:
                      Get.isDarkMode ? ColorDarkComponents : Colors.white,
                  foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
                  title: Text(widget.title),
                )
              : null,
          body: widget.body),
    );
  }
}
