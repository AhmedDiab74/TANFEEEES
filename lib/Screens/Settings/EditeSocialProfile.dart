import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdataNorifactions.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomButton.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomTextField.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/EditeProfileScreen2.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

class EditeSocialProfile extends StatefulWidget {
  const EditeSocialProfile({super.key});

  @override
  State<EditeSocialProfile> createState() => _EditeSocialProfileState();
}

class _EditeSocialProfileState extends State<EditeSocialProfile> {
  final getimydata = Get.find<GetMyUserDataCont>();
  TextEditingController facebook = TextEditingController();
  TextEditingController Twitter = TextEditingController();
  TextEditingController Vkontakte = TextEditingController();
  TextEditingController Linkedin = TextEditingController();
  TextEditingController Instagram = TextEditingController();
  TextEditingController YouTube = TextEditingController();

  ameen() {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        facebook.text = getimydata.data[i].facebook;
        Twitter.text = getimydata.data[i].twitter;
        Vkontakte.text = getimydata.data[i].vk;
        Linkedin.text = getimydata.data[i].linkedin;
        Instagram.text = getimydata.data[i].instgram;
        facebook.text = getimydata.data[i].facebook;
        YouTube.text = getimydata.data[i].youtube;
      });
  }

  @override
  void initState() {
    ameen();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.grey[300],
      appBar: AppBar(
        foregroundColor: Get.isDarkMode ? Colors.white : ColorTheme,
        title: Text('Social Link'.tr),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.015,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                // WidgetUpdateEditeProfile(
                //   controller: facebook,
                //   icon: Ionicons.logo_facebook,
                //   name: 'Facebbok'.tr,
                // ),
                CustomTextField(
                    'Facebook', facebook, Ionicons.logo_facebook, false),
              SizedBox(
                height: Get.height * 0.015,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField(
                    'Twitter', Twitter, Ionicons.logo_twitter, false),
              SizedBox(
                height: Get.height * 0.015,
              ),
              CustomTextField('Vkontakte', Vkontakte, Ionicons.logo_vk, false),
              SizedBox(
                height: Get.height * 0.015,
              ),
              CustomTextField(
                  'Linkedin', Linkedin, Ionicons.logo_linkedin, false),
              SizedBox(
                height: Get.height * 0.015,
              ),
              CustomTextField(
                  'Instagram', Instagram, Ionicons.logo_instagram, false),
              SizedBox(
                height: Get.height * 0.015,
              ),
              CustomTextField('YouTube', YouTube, Ionicons.logo_youtube, false),
              SizedBox(
                height: Get.height * 0.015,
              ),
            InkWell(onTap: (){
              if(facebook.text!=getimydata.data[0].facebook){
                ApiUpdataNorifactions.UpdateUserData(
                    vals: 'facebook', nump: facebook.text);

              };   if(Twitter.text!=getimydata.data[0].twitter){
                ApiUpdataNorifactions.UpdateUserData(
                    vals: 'twitter', nump: Twitter.text);

              };   if(Instagram.text!=getimydata.data[0].instgram){
                ApiUpdataNorifactions.UpdateUserData(
                    vals: 'instgram', nump: Instagram.text);

              };   if(Vkontakte.text!=getimydata.data[0].vk){
                ApiUpdataNorifactions.UpdateUserData(
                    vals: 'vk', nump: Vkontakte.text);

              }; if(Linkedin.text!=getimydata.data[0].linkedin){
                ApiUpdataNorifactions.UpdateUserData(
                    vals: 'linkedin', nump: Linkedin.text);

              };   if(YouTube.text !=getimydata.data[0].youtube){
                ApiUpdataNorifactions.UpdateUserData(
                    vals: 'youtube', nump: YouTube.text);

              }
              getimydata.getUserdata();
              Get.back();

            },child:   CustomButton(
              'Save',
              null,
            ),)
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         color: ColorTheme,
              //         borderRadius: BorderRadius.circular(10)),
              //     width: Get.width,
              //     padding: EdgeInsets.symmetric(vertical: 10),
              //     margin: EdgeInsets.symmetric(horizontal: 10),
              //     child: Center(
              //         child: Text(
              //       'Save'.tr,
              //       style: GoogleFonts.poppins(
              //           fontWeight: FontWeight.normal,
              //           color: Colors.white,
              //           fontSize: 18),
              //     )),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class TexteditingController {
  static textEditingController(s1s1s1) {
    s1s1s1 = TextEditingController();

    return s1s1s1;
  }
}
