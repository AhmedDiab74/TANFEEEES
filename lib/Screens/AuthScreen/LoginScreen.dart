import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiLogin.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLogin/AppleLogin.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/OtpScreen.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLogin/GoogleLogin.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomButton.dart';
import 'package:wowondertimelineflutterapp/Util/SocialLogin/FaceBookLogin.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomSnackbar.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/RegisterScreen.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomTextField.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/OneSignalNotification.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/ForgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool lod = false;

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    OneSignalNotf();
    super.initState();
  }

  @override
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
              Center(
                child: Container(
                    child: SvgPicture.asset(
                  SvgImages.login,
                  height: Get.height * 0.20,
                  width: Get.width * 0.30,
                )),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                child: Text(
                  'WELCOME BACK'.tr,
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Get.isDarkMode
                          ? Colors.white
                          : Color.fromARGB(255, 15, 45, 82)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                child: Text(
                  'Account Log in'.tr,
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Get.isDarkMode
                          ? Colors.white
                          : Color.fromARGB(255, 15, 45, 82)),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              CustomTextField('Email ID / Mobile number', _email,
                  Icons.alternate_email, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField('Password', _password, Icons.fingerprint, true),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Row(
                children: [
                  Container(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.to(ForgotPasswordScreen());
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 12),
                                  child: Text('Forgot Password?'.tr,
                                      style: GoogleFonts.cairo(
                                        fontWeight: FontWeight.bold,
                                        color: ColorTheme,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ),
                        ),
                        CustomButton(
                          'Login',
                          _login,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (Social_Login_Page)
                SizedBox(
                  height: Get.height * 0.05,
                ),
              if (Social_Login_Page)
                Center(
                  child: Container(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width * 0.30,
                          height: 1,
                          color: Colors.grey[400],
                        ),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Center(
                            child: Text(
                          'Or Login with'.tr,
                          style: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Container(
                          width: Get.width * 0.30,
                          height: 1,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
              if (Social_Login_Page)
                Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (Login_With_Facebook) FaceBookLoginAuth2(),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          if (Login_With_Google) SignInDemo2(),
                          SizedBox(
                            width: Get.width * 0.02,
                          ),
                          if (Login_With_Apple) AppleLogin2(),
                          // if (Login_With_Facebook)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              if (User_Registration == '1')
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                      child: InkWell(
                        onTap: () {
                          Get.offAll(RegisteScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?'.tr,
                                style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.bold,
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              Text(
                                'Register'.tr,
                                style: GoogleFonts.urbanist(
                                    fontWeight: FontWeight.bold,
                                    color: ColorTheme,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        )),
      ),
    );
  }

  Future<void> _login() async {
    loding(true);

    var LoginVar = await LoginApi.fetLogin(_email.text, _password.text);

    if (LoginVar['api_status'] == 200) {
      if (LoginVar['membership']) {
        loding(false);
      } else {
        loding(false);
        if (LoginVar['message'] == 'Please enter your confirmation code') {
          Get.to(OptScreen(
            use: LoginVar['user_id'].toString(),
          ));
        } else {
          SharedP.Save('tok', LoginVar['access_token'].toString());
          SharedP.Save('user_id', LoginVar['user_id'].toString());
          // showCustomSnackbar(context, 'Login Successful', true);
          Get.offAll(HomeNavBar());
        }
      }
    } else {
      showCustomSnackbar(
        snackbar: 'error',
        context: context,
        message: LoginVar['errors']['error_text'],
      );
      loding(false);
    }
  }

  loding(lods) {
    setState(() {
      lod = lods;
    });
  }
}
