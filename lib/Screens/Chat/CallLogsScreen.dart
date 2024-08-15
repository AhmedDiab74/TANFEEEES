import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class CallLogsScreen extends StatelessWidget {
  const CallLogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call Logs'),
        backgroundColor: Get.isDarkMode ? NavBarColorDark : ColorTheme,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [],
        )),
      ),
    );
  }
}
