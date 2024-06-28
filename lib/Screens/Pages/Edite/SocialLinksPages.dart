import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPageData.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPageVerification.dart';

import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';

class SocialLinksPages extends StatefulWidget {
  final String page_id;
  const SocialLinksPages({super.key, required this.page_id});

  @override
  State<SocialLinksPages> createState() => _SocialLinksPagesState();
}

class _SocialLinksPagesState extends State<SocialLinksPages> {
  TextEditingController facebook = TextEditingController();
  TextEditingController twitter = TextEditingController();
  TextEditingController instgram = TextEditingController();
  TextEditingController vk = TextEditingController();
  TextEditingController linkedin = TextEditingController();
  TextEditingController youtube = TextEditingController();
  bool loding = true;
  List<GetPagesDataModel> data = [];
  getData() async {
    await ApiPageData.postsData(widget.page_id).then((value) {
      loding = false;
      setState(() {
        data = value.toList();
        facebook = TextEditingController(text: value[0].facebook);
        vk = TextEditingController(text: value[0].vk.toString());
        linkedin = TextEditingController(text: value[0].linkedin.toString());

        twitter = TextEditingController(text: value[0].twitter.toString());
        instgram = TextEditingController(text: value[0].instgram);
        youtube = TextEditingController(text: value[0].youtube);
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return loding
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Textfiled(textEdtit: facebook, title: 'Facebook Username'),
                Textfiled(textEdtit: twitter, title: 'Twitter Username'),
                Textfiled(textEdtit: instgram, title: 'Instagram Username'),
                Textfiled(textEdtit: vk, title: 'Vkontakte Username'),
                Textfiled(textEdtit: linkedin, title: 'Linkedin Username'),
                Textfiled(textEdtit: youtube, title: 'Youtube Username'),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    var ameen = await ApiUpdatePage.upd(
                      page_id: widget.page_id,
                      facebook: facebook.text,
                      twitter: twitter.text,
                      instgram: instgram.text,
                      vk: vk.text,
                      linkedin: linkedin.text,
                      youtube: youtube.text,
                    );
                    print(ameen);
                    if (ameen['api_status'] == '400') {
                      Get.snackbar('', ameen['errors']['error_text']);
                    } else {
                      Get.snackbar('', ameen['message']);
                    }
                    //             facebook,
                    // twitter,
                    // instgram,
                    // vk,
                    // linkedin,
                    // youtube,
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorTheme,
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget Textfiled({required title, required textEdtit, iconss, ontap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(37, 158, 158, 158)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: textEdtit,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: title,
              suffixIcon: iconss,
            ),
          ),
        ),
      ),
    );
  }
}
