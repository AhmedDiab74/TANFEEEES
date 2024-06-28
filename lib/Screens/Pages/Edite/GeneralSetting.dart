import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPageData.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiPageVerification.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/GetPagesDataModel.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class GeneralSetting extends StatefulWidget {
  final String page_id;
  const GeneralSetting({super.key, required this.page_id});

  @override
  State<GeneralSetting> createState() => _GeneralSettingState();
}

class _GeneralSettingState extends State<GeneralSetting> {
  bool loding = true;
  bool chek_box = false;
  String verf = 'Request';

  TextEditingController page_name = TextEditingController();
  TextEditingController page_title = TextEditingController();
  TextEditingController call_action_type_url = TextEditingController();
  TextEditingController call_action_type_text = TextEditingController();

  List<Map<String, dynamic>> catgor = [];
  List<Map<String, dynamic>> callType = [];
  Map<String, dynamic>? selectedGender;
  List<GetPagesDataModel> data = [];
  String Sellcted_CatgNum = '2486';
  String seleVVV = '0';
  getAllDataPage() async {
    getGenderOptions().then((options) {
      setState(() {
        catgor = options;
      });
    });

    await ApiPageData.postsData(widget.page_id).then((value) {
      loding = false;
      setState(() {
        data = value.toList();
        page_name = TextEditingController(text: value[0].page_name);
        page_title =
            TextEditingController(text: value[0].page_title.toString());
        call_action_type_url = TextEditingController(
            text: value[0].call_action_type_url.toString());
        seleVVV = value[0].call_action_type;
        print('akjsdklasjldjkals ${value[0].call_action_type}');
        value[0].call_action_type == '0' ? seleVVV = '1' : '';

        Sellcted_CatgNum = value[0].page_category;
        if (value[0].users_post == '0') {
          chek_box = false;
        } else {
          chek_box = true;
        }
        print(chek_box);
      });
    });
  }

  @override
  void initState() {
    getAllDataPage();
    print('klajsdlkjsalkdjksad ${data.length}');
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
                Textfiled(textEdtit: page_title, title: 'Channel name'),
                Textfiled(textEdtit: page_name, title: 'Channel URL'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('${accounts[0]['sm0']} URL'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<Map<String, dynamic>>(
                        underline: SizedBox(),
                        isExpanded: true,
                        hint: Text(
                          GetSetList[0]['page_categories'][Sellcted_CatgNum]
                              .toString(),
                          style: TextStyle(
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black),
                        ),
                        items: catgor.map((Map<String, dynamic> cat) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: cat,
                            child: Text(cat['value'].toString()),
                          );
                        }).toList(),
                        onChanged: (Map<String, dynamic>? pageCato) {
                          // Handle the selected gender
                          setState(() {
                            Sellcted_CatgNum = pageCato?['key'];
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        isExpanded: true,
                        value: ameenssss.keys.elementAt(int.parse(seleVVV) - 1),
                        items: List.generate(
                          ameenssss.length,
                          (int index) {
                            return DropdownMenuItem(
                              value: ameenssss.keys.elementAt(index),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      ameenssss.values.elementAt(index),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        onChanged: (v) {
                          print(v);
                          setState(() {
                            int va = int.parse(v.toString());
                            int w = va;
                            seleVVV = w.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Textfiled(
                    textEdtit: call_action_type_url,
                    title: 'Call to target url'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Users can post on my channel'),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: chek_box,
                        onChanged: (val) {
                          setState(() {
                            chek_box = true;
                          });
                        }),
                    Text('Enable'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                        value: !chek_box,
                        onChanged: (val) {
                          setState(() {
                            chek_box = false;
                          });
                        }),
                    Text('Disable'),
                  ],
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Verification',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                if (data[0].verified == '1')
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('This channel has been verified'),
                  ),
                if (data[0].verified != '1')
                  InkWell(
                    onTap: () async {
                      final a = await ApiPageVerification.ver(
                          page_id: widget.page_id);
                      print(a);
                      if (a['code'] == 0) {
                        setState(() {
                          verf = 'Request';
                        });
                      } else if (a['code'] == 1) {
                        setState(() {
                          verf = 'Been sent';
                        });
                      }
                      Get.snackbar('', a);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 5, 106, 57),
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            verf,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () async {
                    var ameen = await ApiUpdatePage.upd(
                      page_id: widget.page_id,
                      page_name: page_name.text,
                      page_title: page_title.text,
                      call_action_type_url: call_action_type_url.text,
                      users_post: chek_box ? '1' : '0',
                      page_category: Sellcted_CatgNum,
                      call_action_type_text: seleVVV,
                    );
                    Get.snackbar('', ameen['message']);
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

Future<List<Map<String, dynamic>>> getGenderOptions() async {
  Map<String, dynamic> data = GetSetList[0]['page_categories'];

  List<Map<String, dynamic>> options = [];

  data.forEach((key, value) {
    options.add({'key': key, 'value': value});
  });

  return options;
}

Future<List<Map<String, dynamic>>> getGenderOptions2() async {
  List ameen22 = [ameenssss];
  Map<String, dynamic> data = ameen22[0];

  List<Map<String, dynamic>> options = [];

  data.forEach((key, value) {
    options.add({'key': key, 'value': value});
  });

  return options;
}

Map ameenssss = {
  '1': 'Read more',
  '2': 'Shop now',
  '3': 'View now',
  '4': 'Visit now',
  '5': 'Book now',
  '6': 'Learn more',
  '7': 'Play now',
  '8': 'Bet now',
  '9': 'Donate',
  '10': 'Apply here',
  '11': 'Quote here',
  '12': 'Order now',
  '13': 'Book tickets',
  '14': 'Enroll now',
  '15': 'Find a card',
  '16': 'Get a quote',
  '17': 'Get tickets',
  '18': 'Locate a dealer',
  '19': 'Order online',
  '20': 'Preorder now',
  '21': 'Schedule now',
  '22': 'Sign up now',
  '23': 'Subscribe',
  '24': 'Register now'
};
