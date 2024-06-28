import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPageData.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPageVerification.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';

class ProfileSeeting extends StatefulWidget {
  final String page_id;
  const ProfileSeeting({super.key, required this.page_id});

  @override
  State<ProfileSeeting> createState() => _ProfileSeetingState();
}

class _ProfileSeetingState extends State<ProfileSeeting> {
  TextEditingController company = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController about = TextEditingController();
  bool loding = true;
  List<GetPagesDataModel> data = [];
  getData() async {
    await ApiPageData.postsData(widget.page_id).then((value) {
      loding = false;
      setState(() {
        data = value.toList();
        company = TextEditingController(text: value[0].company);
        address = TextEditingController(text: value[0].address.toString());
        phone = TextEditingController(text: value[0].phone.toString());

        website = TextEditingController(text: value[0].website.toString());
        about = TextEditingController(text: value[0].about);
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Textfiled(textEdtit: company, title: 'Ciompany'),
                Textfiled(textEdtit: address, title: 'Location'),
                Textfiled(textEdtit: phone, title: 'Phone'),
                Textfiled(textEdtit: website, title: 'WebSite'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('(e.g: https://viraldrifts.com)'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: Get.height * 0.20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(37, 158, 158, 158)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: about,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'About',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    var ameen = await ApiUpdatePage.upd(
                      page_id: widget.page_id,
                      company: company.text,
                      address: address.text,
                      phone: phone.text,
                      website: website.text,
                      about: about.text,
                    );
                    print(ameen);
                    if (ameen['api_status'] == '400') {
                      Get.snackbar('', ameen['errors']['error_text']);
                    } else {
                      Get.snackbar('', ameen['message']);
                    }
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
      padding: const EdgeInsets.all(8.0),
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
