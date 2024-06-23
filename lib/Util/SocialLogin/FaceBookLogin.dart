import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/NameScreen.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSocialLogin.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FaceBookLoginAuth2 extends StatefulWidget {
  const FaceBookLoginAuth2({super.key});

  @override
  State<FaceBookLoginAuth2> createState() => _FaceBookLoginAuth2State();
}

class _FaceBookLoginAuth2State extends State<FaceBookLoginAuth2> {
  @override
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
      print(_accessToken);
    }
    setState(() {
      _accessToken = result.accessToken;
    });
    print(_accessToken != null);
    if (_accessToken!.token.isNotEmpty) {
      var tok =
          await ApiSocialLogin.lgin('facebook', _accessToken!.token.toString());
      print(tok.toString());
      if (tok['is_new']) {
        SharedP.Save('tok', tok['access_token'].toString());
        SharedP.Save('user_id', tok['user_id'].toString());
        Get.offAll(NameScreen());
        print('new');
      } else {
        SharedP.Save('tok', tok['access_token'].toString());
        SharedP.Save('user_id', tok['user_id'].toString());
        Get.offAll(HomeNavBar());
      }
    }
  }

  Future<void> ameenjawadhamed() async {
    final status = await OneSignal.shared.getDeviceState();
  }

  Widget build(BuildContext context) {
    ameenjawadhamed();
    print(_userData);
    return InkWell(
      onTap: _login,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(
                color: Get.isDarkMode ? ColorDarkComponents : Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Get.isDarkMode ? ColorDarkComponents : Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/facebook.png',
                height: 20,
                width: 20,
              ),
              // Text(
              //   'Facebook'.tr,
              //   style: GoogleFonts.poppins(fontWeight: FontWeight.w400),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
