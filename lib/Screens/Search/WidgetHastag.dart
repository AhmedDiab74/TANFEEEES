import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

class WigsetHastag extends StatelessWidget {
  WigsetHastag({
    required this.name,
    required this.conut,
    super.key,
  });

  String name;
  String conut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 27,
                backgroundColor: Color(0xffF8F9FD),
                child: Text(
                  '#',
                  style: TextStyle(fontSize: 30, color: Color(0xff334155)),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              name,
                              style: SafeGoogleFont(Fonts.font2,
                                  fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                          ],
                        ),
                        Text(
                          conut,
                          style: SafeGoogleFont(Fonts.font2,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Divider(),
        )
      ],
    );
  }
}
