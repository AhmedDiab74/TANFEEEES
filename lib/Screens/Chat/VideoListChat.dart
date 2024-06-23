import 'dart:io';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoListChat extends StatefulWidget {
  VideoListChat(
      {Key, key, required this.videoPlayerController, required this.looping})
      : super(key: key);
  VideoPlayerController videoPlayerController;
  bool looping;
  @override
  _VideoListChatState createState() => _VideoListChatState();
}

class _VideoListChatState extends State<VideoListChat> {
  late ChewieController videosController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    widget.videoPlayerController.initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: widget.videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  Widget progressBar() {
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController),
    );
  }
}

class VideoListChat2 extends StatefulWidget {
  VideoListChat2({Key, key, required this.video, required this.looping})
      : super(key: key);
  String video;
  bool looping;
  @override
  _VideoListChat2State createState() => _VideoListChat2State();
}

class _VideoListChat2State extends State<VideoListChat2> {
  late VideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    videoPlayerController = VideoPlayerController.network(widget.video)
      ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  Widget progressBar() {
    return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.50,
      height: Get.height * 0.50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CustomVideoPlayer(
            customVideoPlayerController: _customVideoPlayerController),
      ),
    );
  }
}
