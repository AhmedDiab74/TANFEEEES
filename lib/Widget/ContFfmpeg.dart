// import 'dart:async';

// import 'package:appinio_video_player/appinio_video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';

// class ContFFmpeg extends GetxController {
//   late VideoPlayerController _videoPlayerController,
//       _videoPlayerController2,
//       _videoPlayerController3,
//       _videoPlayerController4,
//       _videoPlayerController5,
//       _videoPlayerController6,
//       _videoPlayerController7,
//       _videoPlayerController8;
//    CustomVideoPlayerController customVideoPlayerController  =;
//   bool _isDisposed = false;
//   Completer<void>? _creatingCompleter;

//   final CustomVideoPlayerSettings _customVideoPlayerSettings =
//       const CustomVideoPlayerSettings(
//     //TODO: play around with these parameters
//     // autoFadeOutControls: true,
//     // controlBarAvailable: true,
//     // playbackSpeedButtonAvailable: false,
//     // // controlBarMargin: const EdgeInsets.all(10),
//     // controlBarPadding: const EdgeInsets.all(0),
//     // showPlayButton: true,
//     // playButton: const Icon(
//     //   Icons.play_circle,
//     //   color: Colors.white,
//     // ),
//     // pauseButton: const Icon(
//     //   Icons.pause_circle,
//     //   color: Colors.white,
//     // ),
//     // enterFullscreenButton: const Icon(
//     //   Icons.fullscreen,
//     //   color: Colors.white,
//     // ),
//     // exitFullscreenButton: const Icon(
//     //   Icons.fullscreen_exit,
//     //   color: Colors.white,
//     // ),
//     controlBarDecoration: BoxDecoration(
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//           topRight: Radius.circular(20)),
//       color: ColorTheme,
//     ),
//     //showFullscreenButton: false,
//     // showDurationPlayed: false,
//     // showDurationRemaining: false,
//     //enterFullscreenOnStart: true,
//     exitFullscreenOnEnd: true,
//     // durationRemainingTextStyle: const TextStyle(color: Colors.black),
//     // durationPlayedTextStyle: const TextStyle(color: Colors.black, fontSize: 18),
//     // systemUIModeAfterFullscreen: SystemUiMode.leanBack,
//     // systemUIModeInsideFullscreen: SystemUiMode.edgeToEdge,
//     // customVideoPlayerProgressBarSettings: CustomVideoPlayerProgressBarSettings(
//     //   reachableProgressBarPadding: EdgeInsets.all(10),
//     //   progressBarHeight: 10,
//     //   progressBarBorderRadius: 30,
//     //   bufferedColor: Colors.red,
//     //   progressColor: Colors.green,
//     //   backgroundColor: Colors.purple,
//     //   allowScrubbing: true,
//     //   showProgressBar: true,
//     // ),
//   );

//   void playVid(
//       {required audovid,
//       required context,
//       required v360p,
//       required v480p,
//       required v720p,
//       required v1080,
//       required v2048p,
//       required v4096p,
//       required has4096p,
//       required has2048p,
//       required has1080,
//       required has720p,
//       required has480p,
//       required has360p,
//       required has240p,
//       required}) async {
//     _videoPlayerController = VideoPlayerController.network(
//       audovid,
//     )..initialize().then((value) => update());
//     _videoPlayerController2 = VideoPlayerController.network(v360p);
//     _videoPlayerController3 = VideoPlayerController.network(v480p);

//     _videoPlayerController4 = VideoPlayerController.network(v720p);
//     _videoPlayerController5 = VideoPlayerController.network(v1080);
//     _videoPlayerController6 = VideoPlayerController.network(v2048p);
//     _videoPlayerController7 = VideoPlayerController.network(v4096p);
//     _videoPlayerController8 = VideoPlayerController.network(v4096p);
//     customVideoPlayerController = CustomVideoPlayerController(
//       context: context,
//       videoPlayerController: _videoPlayerController,
//       customVideoPlayerSettings: _customVideoPlayerSettings,
//       additionalVideoSources: {
//         if (has4096p == '1') "4096p 4k": _videoPlayerController7,
//         if (has2048p == '1') "2048p 2K": _videoPlayerController6,
//         if (has1080 == '1') "1080p FHD": _videoPlayerController5,
//         if (has720p == '1') "720p HD": _videoPlayerController4,
//         if (has480p == '1') "480p": _videoPlayerController3,
//         if (has360p == '1') "360p": _videoPlayerController2,
//         if (has240p == '1') "240p": _videoPlayerController8,
//         "Normal": _videoPlayerController,
//       },
//     );
//   }

//   void killVidPlayer() {
//     customVideoPlayerController.dispose();
//     _videoPlayerController.dispose();
//     _videoPlayerController2.dispose();
//     _videoPlayerController3.dispose();
//     _videoPlayerController4.dispose();
//     _videoPlayerController5.dispose();
//     _videoPlayerController6.dispose();
//     _videoPlayerController7.dispose();
//     _videoPlayerController8.dispose();
//   }

//   @override
//   void onInit() {
// customVideoPlayerController;
//     super.onInit();
//   }

//   @override
//   void onClose() {
//     killVidPlayer();
//     if (_videoPlayerController.value.isPlaying) _videoPlayerController.pause();
//     _videoPlayerController;
//     super.onClose();
//   }
// }
