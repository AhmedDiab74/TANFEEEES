import 'package:flutter/material.dart';
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:wowondertimelineflutterapp/Screens/Blog/BlogComment.dart';

class BlogCommentsScreen extends StatefulWidget {
  @override
  _BlogCommentsScreenState createState() => _BlogCommentsScreenState();
}

class _BlogCommentsScreenState extends State<BlogCommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: ColorTheme,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < 30; i++) CommentsTile(),
          ],
        ),
      )),
    );
  }
}
