import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelAdmin extends StatefulWidget {
  const ChannelAdmin({super.key});

  @override
  State<ChannelAdmin> createState() => _ChannelAdminState();
}

class _ChannelAdminState extends State<ChannelAdmin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(37, 158, 158, 158)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Search..',
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: Get.height * 0.50,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffFFE6E2),
                  maxRadius: 50,
                  child: Icon(
                    Icons.group,
                    color: Color(0xffFC573B),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No members to show',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
        )
      ],
    );
  }
}
