import '../../Images.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Themes.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Util/SocialLogin/AppleLogin.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import '../../Util/SocialLogin/GoogleLogin.dart';
import '../../Util/SocialLogin/FaceBookLogin.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiRegister.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/NameScreen.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomButton.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomSnackbar.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomTextField.dart';


class RegisteScreen extends StatefulWidget {
  const RegisteScreen({super.key});

  @override
  State<RegisteScreen> createState() => _RegisteScreenState();
}

final Uri _url = Uri.parse(accounts[0]['termsOfUse']);

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

final Uri _url2 = Uri.parse(accounts[0]['privacyPolicy']);

Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw 'Could not launch $_url2';
  }
}

bool lod = false;
bool chekbox = false;

class _RegisteScreenState extends State<RegisteScreen> {
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        child: SvgPicture.asset(
                      SvgImages.register,
                      height: Get.height * 0.12,
                      width: Get.width * 0.10,
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                  child: Text(
                    'JOIN THE TEAM'.tr,
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
                    'Create Account'.tr,
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Get.isDarkMode
                            ? Colors.white
                            : Color.fromARGB(255, 15, 45, 82)),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                CustomTextField(
                    'username', _username, Icons.account_circle, false),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                CustomTextField('Email', _email, Icons.alternate_email, false),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                CustomTextField('Password', _password, Icons.fingerprint, true),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      chekbox = !chekbox;
                    });
                  },
                  child: Container(
                    height: Get.height * 0.05,
                    width: Get.width,
                    padding: EdgeInsets.only(left: 5, right: 5),
                    margin: EdgeInsets.only(left: 25, right: 25),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? ColorDarkComponents
                            : Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: chekbox,
                            onChanged: (val) {
                              setState(() {
                                chekbox = val!;
                              });
                            },
                          ),
                          // SizedBox(width: Get.width * 0.01),
                          Text(
                            'I agree to the'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                            ),
                          ),

                          SizedBox(
                            width: 3,
                          ),
                          InkWell(
                            onTap: () {
                              _launchUrl();
                            },
                            child: Text(
                              'Terms of Service'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Get.isDarkMode
                                    ? colorTextBoardingDark1
                                    : colorTextBoardingLight1,
                              ),
                            ),
                          ),
                          Text(
                            ' and '.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _launchUrl2();
                            },
                            child: Text(
                              'Privacy Policy'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Get.isDarkMode
                                    ? colorTextBoardingDark1
                                    : colorTextBoardingLight1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomButton(
                  'Register',
                  _login,
                ),
                SizedBox(
                  height: Get.height * 0.04,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: InkWell(
                    onTap: () {
                      Get.offAll(LoginScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I have a account !'.tr,
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
                            'Login'.tr,
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
              ],
            )),
          ),
        ),
        // if (lod)
        //   Container(
        //       height: Get.height,
        //       width: Get.width,
        //       color: Color.fromARGB(42, 76, 76, 76),
        //       child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Future<void> _login() async {
    loding(true);

    var LoginVar = chekbox
        ? await ApiRegister.fetReg(
            _username.text, _email.text, _password.text, '', '')
        : '';

    if (chekbox) {
      if (LoginVar['api_status'] == 200) {
        if (LoginVar['membership']) {
          loding(false);
        } else {
          SharedP.Save('tok', LoginVar['access_token'].toString());
          SharedP.Save('user_id', LoginVar['user_id'].toString());
          loding(false);
          Get.offAll(NameScreen());
        }
        loding(false);
        Get.offAll(NameScreen());
      } else {
        // Get.snackbar(
        //   'errors',
        //   LoginVar['errors']['error_text'],
        // );
        showCustomSnackbar(
          snackbar: 'error',
          context: context,
          message: LoginVar['errors']['error_text'],
        );

        loding(false);
      }
    } else {
      // Get.snackbar('', 'You must first agree to the Terms of Use');
      showCustomSnackbar(
        snackbar: 'error',
        context: context,
        message: 'You must first agree to the Terms of Use',
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
