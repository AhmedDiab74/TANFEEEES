import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';

class VideoPlayerCached extends StatefulWidget {
  const VideoPlayerCached({
    Key? key,
    required this.urls,
    required this.imageTemp,
  }) : super(key: key);

  final String urls;
  final String imageTemp;
  @override
  State<VideoPlayerCached> createState() => _VideoPlayerCachedState();
}

class _VideoPlayerCachedState extends State<VideoPlayerCached> {
  late CachedVideoPlayerPlusController controller;
  @override
  void initState() {
    controller = CachedVideoPlayerPlusController.networkUrl(widget.urls.toUri);
    controller.initialize().then((value) {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    controller.pause();
    super.dispose();
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget build(BuildContext context) {
    return Center(
        child: controller.value.isInitialized
            ? VisibilityDetector(
                key: ObjectKey(controller),
                onVisibilityChanged: (visibility) {
                  if (visibility.visibleFraction > 0.5) {
                    controller.play();
                  } else {
                    if (mounted) {
                      controller.pause();
                    }
                  }
                },
                child: CachedVideoPlayerPlus(controller),
              )
            : widget.imageTemp.isEmpty
                ? SizedBox()
                : Container(
                    width: sizedwidth(context),
                    height: sizedHeight(context),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover, imageUrl: widget.imageTemp),
                  ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}