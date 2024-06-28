import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';

class Createadsscreen extends StatefulWidget {
  const Createadsscreen({super.key});

  @override
  State<Createadsscreen> createState() => _CreateadsscreenState();
}

class _CreateadsscreenState extends State<Createadsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor:  Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Create'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Company name',
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(44, 158, 158, 158)),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    )),


                SizedBox(
                  height: 10,
                ),
                Text(
                  'Image',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  'Select a image for your campign',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Container(
                  width: sizedwidth(context),
                  height: sizedHeight(context) * 0.30,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.photo, color: Colors.green),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Chose Image',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),



                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Campaign title name',
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(44, 158, 158, 158)),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Campaign description',
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                    width: Get.width,
                    height: sizedHeight(context)*0.20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(44, 158, 158, 158)),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    )),
                Text(
                  'Tell users what your campaingn is about',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
