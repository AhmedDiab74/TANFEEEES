import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Earnings/MyPointsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Earnings/MyBalanceScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Earnings/SendMonyeScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Earnings/MyAffiliatesScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/Earnings/WithdarawalsScreen.dart';
import 'package:wowondertimelineflutterapp/Screens/HelpAndSupport/SupportScreen.dart';

class HomeScreenEarnings extends StatefulWidget {
  const HomeScreenEarnings({super.key});

  @override
  State<HomeScreenEarnings> createState() => _HomeScreenEarningsState();
}

class _HomeScreenEarningsState extends State<HomeScreenEarnings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Earnings'.tr),
          backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        backgroundColor: Get.isDarkMode
            ? ColorDarkBackground
            : Theme.of(context).scaffoldBackgroundColor,
        body: GridView.count(
          crossAxisCount: 2,
          children: [
            if (Affiliate_System == '1')
              _TextSupport(
                text: 'My Affiliates'.tr,
                icon: SvgImages.Language,
                onTap: () {
                  Get.to(MyAffiliatesScreen());
                },
              ),
            _TextSupport(
              icon: SvgImages.Language,
              text: 'My Balance'.tr,
              onTap: () {
                Get.to(MyBalanceScreen());
              },
            ),
            // _TextSupport(
            //   icon: SvgImages.Language,
            //   text: 'My Points'.tr,
            //   onTap: () {
            //     Get.to(MyPointsScreen());
            //   },
            // ),
            // _TextSupport(
            //   icon: SvgImages.Language,
            //   text: 'Withdrawals'.tr,
            //   onTap: () {
            //     Get.to(WithdrawalsScreen());
            //   },
            // ),
            _TextSupport(
              icon: SvgImages.Language,
              text: 'Send Money'.tr,
              onTap: () {
                Get.to(SendMonyeScreen());
              },
            ),
          ],
        ));
  }
}

class _TextSupport extends StatelessWidget {
  _TextSupport({
    required this.text,
    required this.icon,
    this.onTap,
    super.key,
  });

  final String text;
  final String icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3),
        child: Container(
          decoration: BoxDecoration(
              color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
            child: Container(
              width: Get.width * 0.40,
              height: Get.height * 0.20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          icon,
                          color: ColorTheme,
                          // color: Color.fromARGB(255, 255, 255, 255),
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          text,
                          style: SafeGoogleFont(Fonts.font1,
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
