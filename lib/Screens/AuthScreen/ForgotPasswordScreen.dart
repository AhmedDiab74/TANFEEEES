import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:googleapis/admob/v1.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiRestPass.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/LoginScreen.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomButton.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomTextField.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _email = TextEditingController();

  bool lod = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      elevation: 0,
      centerTitle: false,
      body: Scaffold(
        appBar: AppBar(
          foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
          backgroundColor:
              Get.isDarkMode ? ColorDarkBackground : Colors.grey[300],
          elevation: 0,
          title: Text(
            'Forgot Password',
            style: TextStyle(fontSize: 15),
          ),
        ),
        backgroundColor:
            Get.isDarkMode ? ColorDarkBackground : Colors.grey[300],
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    //     child: SvgPicture.asset(
                    //   SvgImages.forgot,
                    //   height: Get.height * 0.20,
                    //   width: Get.width * 0.20,
                    // )
                    child: Lottie.asset(
                      AnimatedImages.forgotpass,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Text('Forgot Password'.tr,
                    style: TextStyle(
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                width: Get.width * 0.7,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                      'Enter your email account to reset your password.'.tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                          fontSize: 15, color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 25.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.grey[200],
              //         borderRadius: BorderRadius.circular(12),
              //         border: Border.all(color: Colors.white)),
              //     child: Padding(
              //       padding:
              //           const EdgeInsets.only(left: 20.0, top: 5, bottom: 5),
              //       child: TextField(
              //         controller: _email,
              //         decoration: InputDecoration(
              //           icon: Icon(Icons.alternate_email),
              //           border: InputBorder.none,
              //           hintText: 'Email'.tr,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              CustomTextField('Email', _email, Icons.alternate_email, false),
              SizedBox(
                height: Get.height * 0.02,
              ),

              Container(
                width: Get.width * 0.5,
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      lod = true;
                    });
                    var ameen = await RestPassowrdApi.rest(_email.text);

                    if (ameen['api_status'] == 200) {
                      Get.bottomSheet(
                          // Positioned(child: child),
                          Container(
                              height: Get.height * 0.45,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.005,
                                  ),
                                  Container(
                                    width: Get.width * 0.1,
                                    height: 2,
                                    color: Colors.grey[500],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Image.asset(images.restPasswordIm),
                                  Text(
                                    'E-mail has been sent successfully'.tr,
                                    style: SafeGoogleFont(Fonts.font3,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Text(
                                      'Great news! We\'ve just sent you an email with instructions to reset your password. Please check your inbox, and don\'t forget to look in your spam folder if you don\'t see it in your main inbox. '
                                          .tr,
                                      style: SafeGoogleFont(Fonts.font3,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.grey),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.05),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(LoginScreen());
                                      },
                                      child: Container(
                                        width: Get.width * 0.5,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorTheme,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  color: ColorButtonBorder)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Text('Login'.tr,
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
                                  ),
                                ],
                              )));
                      setState(() {
                        lod = false;
                      });
                    } else {
                      setState(() {
                        lod = false;
                      });

                      Get.snackbar('error', ameen['errors']['error_text']);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: ColorButtonBorder)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text('Reset Password'.tr,
                          style: GoogleFonts.cairo(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      AppBarTrueOrFalse: false,
      loding: lod,
      title: '',
    );
  }
}
