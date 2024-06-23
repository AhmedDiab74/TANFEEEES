import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Images.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Widget/ScaffoldWidget.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdateUserData.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/ForgotPasswordScreen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  final TextEditingController password = TextEditingController();
  final TextEditingController newpass = TextEditingController();
  final TextEditingController repeatpass = TextEditingController();

  bool isVisibilty1 = true;
  bool isVisibilty2 = true;
  bool isVisibilty3 = true;
  void Visibilty1() {
    setState(() {
      isVisibilty1 = !isVisibilty1;
    });
  }

  void Visibilty2() {
    setState(() {
      isVisibilty2 = !isVisibilty2;
    });
  }

  void Visibilty3() {
    setState(() {
      isVisibilty3 = !isVisibilty3;
    });
  }

  String passwordNor = '';
  String passerorr = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Change Password'.tr),
        centerTitle: true,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Center(
                child: Lottie.asset(
                  AnimatedImages.forgotpass,
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: Get.height * 0.06,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Password'.tr,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Container(
                      width: Get.width * 0.80,
                      child: Text(
                          'The new password must be different About the previous password'
                              .tr,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey)),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: ColorThme, spreadRadius: 0.1)
                      // ],
                      borderRadius: BorderRadius.circular(12),
                      color: Get.isDarkMode ? Colors.black : Color(0xffF4F6F8)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextField(
                      obscureText: isVisibilty1,
                      controller: password,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: isVisibilty1
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            Visibilty1();
                          },
                        ),
                        border: InputBorder.none,
                        labelText: 'Old Password'.tr,
                      ),
                    ),
                  ),
                ),
              ),
              Text(passwordNor),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: ColorThme, spreadRadius: 0.1)
                      // ],
                      borderRadius: BorderRadius.circular(12),
                      color: Get.isDarkMode ? Colors.black : Color(0xffF4F6F8)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextField(
                      obscureText: isVisibilty2,
                      controller: newpass,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: isVisibilty2
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            Visibilty2();
                          },
                        ),
                        border: InputBorder.none,
                        labelText: 'New Password'.tr,
                      ),
                    ),
                  ),
                ),
              ),
              Text(passerorr),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: ColorThme, spreadRadius: 0.1)
                      // ],
                      borderRadius: BorderRadius.circular(12),
                      color: Get.isDarkMode ? Colors.black : Color(0xffF4F6F8)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Form(
                      key: fromKey,
                      child: TextFormField(
                        obscureText: isVisibilty3,
                        controller: repeatpass,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: isVisibilty1
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            onPressed: () {
                              Visibilty3();
                            },
                          ),
                          border: InputBorder.none,
                          labelText: 'Confirm Password'.tr,
                        ),
                        validator: (val) {
                          if (val.toString().length <= 4) {
                            print('val');
                            return 'The name cannot be less than 5 burns';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         boxShadow: [
              //           BoxShadow(
              //               color: ColorThme, spreadRadius: 0.1)
              //         ],
              //         borderRadius: BorderRadius.circular(12),
              //         color: Get.isDarkMode ? Colors.black : Colors.white),
              //     child: Padding(
              //       padding: const EdgeInsets.all(2.0),
              //       child: TextField(
              //         controller: repeatpass,
              //         decoration: InputDecoration(
              //           border: InputBorder.none,
              //           labelText: 'Repeat Password',
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(ForgotPasswordScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Forgot Password?'.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: ColorTheme),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    if (newpass.text == repeatpass.text) {
                      if (newpass.text.length < 8) {
                        setState(() {
                          passerorr = 'Password must be more than 8 digits.'.tr;
                        });
                      } else {
                        print('object');
                        var ameen = await ApiUpdateUserData.UpdateUserData(
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          password.text,
                          newpass.text,
                          '',
                          '',
                          '',
                        );
                        if (ameen['api_status'] == '400')
                          setState(() {
                            passwordNor = 'The password is wrong'.tr;
                          });
                        if (ameen['api_status'] == 200)
                          Get.back(closeOverlays: true);
                        print(ameen);
                      }
                    }

                    if (newpass.text != repeatpass.text) {
                      setState(() {
                        passerorr = 'password does not match';
                      });
                    }
                  },
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: ColorTheme,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Create'.tr,
                          style: GoogleFonts.cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
