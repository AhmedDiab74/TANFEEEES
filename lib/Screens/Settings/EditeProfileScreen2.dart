import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomButton.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomSnackbar.dart';
import 'package:wowondertimelineflutterapp/Util/CustomFields/CustomTextField.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiUpdateUserData.dart';
import 'package:wowondertimelineflutterapp/Screens/UserScreen/GetMyUserDataCont.dart';

// ignore: must_be_immutable
class EditeProfileScreen2 extends StatefulWidget {
  EditeProfileScreen2({required this.firstname, super.key});

  String firstname;

  @override
  State<EditeProfileScreen2> createState() => _EditeProfileScreen2State();
}

class _EditeProfileScreen2State extends State<EditeProfileScreen2> {
  bool wit = false;
  final getimydata = Get.find<GetMyUserDataCont>();
  TextEditingController firs = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController working = TextEditingController();
  TextEditingController hart = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController working_link = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    ameen();
    super.initState();
  }

  ameen() {
    for (var i = 0; i < getimydata.data.length; i++)
      setState(() {
        firs.text = getimydata.data[i].first_name;
        lastname.text = getimydata.data[i].last_name;
        phonenumber.text = getimydata.data[i].phone_number;
        website.text = getimydata.data[i].website;
        working.text = getimydata.data[i].working;
        school.text = getimydata.data[i].school;
        working_link.text = getimydata.data[i].working_link;
        address.text = getimydata.data[i].address;
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? ColorDarkBackground : Colors.white,
      appBar: AppBar(
        title: Text('Update Profile'.tr),
        backgroundColor: Get.isDarkMode ? ColorDarkComponents : Colors.white,
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField('FirstName'.tr, firs, Icons.person, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField('Lastname'.tr, lastname, Icons.person, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField('Phone'.tr, phonenumber, Icons.phone, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField(
                    'Location'.tr, address, Ionicons.location_sharp, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField(
                    'Website'.tr, website, Icons.travel_explore, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField('Work Place'.tr, working, Icons.work, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              for (var i = 0; i < getimydata.data.length; i++)
                CustomTextField('Company website'.tr, working_link,
                    Icons.work_outline, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField('School'.tr, school, Icons.school, false),
              SizedBox(
                height: Get.height * 0.02,
              ),
              if (wit)
                Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (!wit)
                CustomButtons(
                  name: 'Save',
                  onTap: () async {
                    setState(() {
                      wit = true;
                    });
                    var next = await ApiUpdateUserData.UpdateUserData(
                      phonenumber.text,
                      lastname.text,
                      firs.text,
                      website.text,
                      working.text,
                      school.text,
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      '',
                      working_link.text,
                      address.text,
                    );
                    if (next['api_status'] == 200)
                      Get.back(closeOverlays: true);

                    showCustomSnackbar(
                      snackbar: 'success',
                      context: context,
                      message: next['message'],
                    );
                    getimydata.getUserdata();
                    if (next['api_status'] == await 200) {
                      setState(() {
                        wit = false;
                      });
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class WidgetUpdateEditeProfile extends StatefulWidget {
  WidgetUpdateEditeProfile(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.name})
      : super(key: key);
  final icon;
  String name;
  TextEditingController controller;

  @override
  State<WidgetUpdateEditeProfile> createState() =>
      _WidgetUpdateEditeProfileState();
}

class _WidgetUpdateEditeProfileState extends State<WidgetUpdateEditeProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextField(
                  widget.name, widget.controller, widget.icon, false),
            ],
          ),
        ),
      ],
    );
  }
}
