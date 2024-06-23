// import 'dart:async';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// const appId = "<-- Insert App Id -->";


// void main() => runApp(const MaterialApp(home: MyApp()));

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int? _remoteUid;
//   bool _localUserJoined = false;
//   late RtcEngine _engine;

//   @override
//   void initState() {
//     super.initState();
//     initAgora();
//   }

 

//   @override
//   void dispose() {
//     super.dispose();

//     _dispose();
//   }

//   Future<void> _dispose() async {
//     await _engine.leaveChannel();
//     await _engine.release();
//   }

//   // Create UI with local view and remote view
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Agora Video Call'),
//       ),
//       body: Stack(
//         children: [
//           Center(
//             child: _remoteVideo(),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: SizedBox(
//               width: 100,
//               height: 150,
//               child: Center(
//                 child: _localUserJoined
//                     ? AgoraVideoView(
//                         controller: VideoViewController(
//                           rtcEngine: _engine,
//                           canvas: const VideoCanvas(uid: 0),
//                         ),
//                       )
//                     : const CircularProgressIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Display remote user's video
//   Widget _remoteVideo() {
//     if (_remoteUid != null) {
//       return AgoraVideoView(
//         controller: VideoViewController.remote(
//           rtcEngine: _engine,
//           canvas: VideoCanvas(uid: _remoteUid),
//           connection: const RtcConnection(channelId: channel),
//         ),
//       );
//     } else {
//       return const Text(
//         'Please wait for remote user to join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }
