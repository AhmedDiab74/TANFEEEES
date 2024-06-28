import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';


import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiDeletePage.dart';



class DeleteChannel extends StatefulWidget {
  final String page_id;
  const DeleteChannel({super.key, required this.page_id});

  @override
  State<DeleteChannel> createState() => _DeleteChannelState();
}

class _DeleteChannelState extends State<DeleteChannel> {
  bool loding = false;
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/svg/deletechannel.svg',
              height: Get.height * 0.3,
              width: sizedwidth(context)*0.01,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Are you sure you want to delete this channel?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(37, 158, 158, 158)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text('Type Current Password'),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          loding
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : InkWell(
                  onTap: () async {
                    showPlatformDialog(
                      context: context,
                      builder: (context) => BasicDialogAlert(
                        title: Text("Do you want to delete?"),
                        content: Text("Are you sure you want to delete these."),
                        actions: <Widget>[
                          BasicDialogAction(
                            title: Text("Cancel"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          BasicDialogAction(
                            title: Text("Delete"),
                            onPressed: () async {
                              setState(() {
                                loding = true;
                              });
                              final ameen = await ApiDeletePage.dele(
                                  password: password.text,
                                  page_id: widget.page_id);
                              print(ameen);
                              if (ameen['api_status'] == '400') {
                                Get.snackbar(
                                    'Error', ameen['errors']['error_text']);
                              } else {
                                Get.back();
                                Get.back();
                                Get.back();
                              }
                              setState(() {
                                loding = false;
                              });

                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(7)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          child: Text(
                            'Delete Chnnel',
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
}
