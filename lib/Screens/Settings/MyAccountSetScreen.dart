import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wowondertimelineflutterapp/Screens/Settings/Country.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomButton.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomTextField.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdateUserData.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

class MyAccountSetScreen extends StatefulWidget {
  const MyAccountSetScreen({super.key});

  @override
  State<MyAccountSetScreen> createState() => _MyAccountSetScreenState();
}

class _MyAccountSetScreenState extends State<MyAccountSetScreen> {
  int str = 0;
  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            useRootNavigator: true,
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        str = DateTime.now().year - _dateTime.year;
        _dateTime = value!;
        str < 17
            ? contDateTime.text =
                '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}'
            : contDateTime.text = 'You must be 18 or over';
      });
    });
  }

  TextEditingController contDateTime = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  final getimydata = Get.find<GetMyUserDataCont>();
  String Country = 'Select Country';
  String countryNup = '0';
  bool male = false;
  String Gender = '2486';
  String error_text = '';
  bool wit = false;
  ameenj() {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        username.text = getimydata.data[i].username;
        email.text = getimydata.data[i].email;
        contDateTime.text = getimydata.data[i].birthday;
        Gender = getimydata.data[i].gender;
        countryNup = getimydata.data[i].country_id;
      });
  }

  List<Map<String, dynamic>> genderOptions = [];
  Map<String, dynamic>? selectedGender;

  @override
  void initState() {
    ameenj();
    print('sdasdasd ewrwer $Gender');
    getGenderOptions().then((options) {
      setState(() {
        genderOptions = options;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        title: Text(
          'My Account'.tr,
        ),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : ColorTheme,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.white,
        elevation: 1,
      ),
      // title:
      // centerTitle: false,
      // elevation: 1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.015,
            ),
            CustomTextField(
                'username', username, Icons.portable_wifi_off, false),
            SizedBox(
              height: Get.height * 0.015,
            ),
            CustomTextField('Email', email, Icons.email, false),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: TextField(
                    controller: contDateTime,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      icon: Icon(Icons.calendar_month_sharp, size: 18),
                      suffixIcon: InkWell(
                        onTap: _showDatePicker,
                        child: Icon(
                          Icons.date_range,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: 'Date Of Birth'.tr,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: Get.isDarkMode ? ColorDarkComponents : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 2)),
                // height: Get.height * 0.07,
                width: Get.width,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Get.isDarkMode ? ColorDarkTextBox : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: ListView.builder(
                          itemCount: ps.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Country = ps[index].toString();
                                        countryNup = index.toString();
                                      });
                                      Get.back();
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      width: Get.width,
                                      child: Center(
                                        child: Text(
                                          ps[index].toString().tr,
                                          style: GoogleFonts.cairo(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Divider(),
                              ],
                            );
                          },
                        ),
                      ),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < ContText.length; i++)
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${ContText[i][countryNup]}'.tr,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.keyboard_arrow_down),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.010,
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 25),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 2)),
              child: DropdownButton<Map<String, dynamic>>(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text(
                  GetSetList[0]['genders'][Gender],
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                items: genderOptions.map((Map<String, dynamic> gender) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: gender,
                    child: Text(gender['value'].toString()),
                  );
                }).toList(),
                onChanged: (Map<String, dynamic>? gender) {
                  // Handle the selected gender
                  setState(() {
                    selectedGender = gender;
                    Gender = gender?['key'];
                    print('sdasdasd : ${gender?['key']}');
                  });
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            str < 18 ? SizedBox() : Text('Your age $str'),
            InkWell(
              onTap: () async {
                setState(() {
                  wit = true;
                });
                var api = await ApiUpdateUserData.UpdateUserData(
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  username.text,
                  email.text,
                  Gender.toString(),
                  contDateTime.text,
                  '',
                  '',
                  countryNup,
                  '',
                  '',
                );
                if (api['api_status'] == 200) Get.back(closeOverlays: true);

                Get.snackbar(
                    'Update',
                    api['message'].toString() == 'null'
                        ? api['errors']['error_text'].toString()
                        : api['message']);
                getimydata.getUserdata();

                setState(() {
                  api['errors'] == null
                      ? error_text = ''
                      : error_text = api['errors']['error_text'];

                  if (api['errors'] != null) wit = false;
                });

                print(api);
              },
              child: CustomButton(
                'Save',
                null,
              ),
            ),
            if (error_text.isNotEmpty) Text(error_text),
            if (wit) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getGenderOptions() async {
    Map<String, dynamic> data = GenderCat;

    List<Map<String, dynamic>> options = [];

    data.forEach((key, value) {
      options.add({'key': key, 'value': value});
    });

    return options;
  }
}
