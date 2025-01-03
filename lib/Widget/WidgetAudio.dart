import 'package:wowondertimelineflutterapp/main.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class WidgetSond extends StatefulWidget {
  WidgetSond({
    required this.postRecord,
    super.key,
  });
  final String postRecord;
  @override
  State<WidgetSond> createState() => _WidgetSondState();
}

class _WidgetSondState extends State<WidgetSond> {
  bool isPlaying = false;
  final _player = AudioPlayer();
  double currentSliderValue = 20;

  Duration duration = Duration.zero;
  Duration postition = Duration.zero;
  @override
  void initState() {
    super.initState();
    bindPlayer();
  }

  bindPlayer() async {
    await _player.setUrl('${accounts[0]['sm0']}/' + widget.postRecord);
    duration = _player.duration!;
    setState(() {});
    _player.positionStream.listen((event) {
      Duration temp = event as Duration;
      postition = temp;
      setState(() {});
    });
  }

  playAction() {
    if (isPlaying) {
      setState(() {});
      _player.pause();
      isPlaying = false;
      print(isPlaying);
    } else {
      setState(() {});
      _player.play();
      isPlaying = true;
      print(isPlaying);
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        children: [
          Slider(
            value: postition.inSeconds.toDouble(),
            min: 0,
            max: duration.inSeconds.toDouble(),
            onChanged: (value) async {
              final seekPostintion = Duration(seconds: value.toInt());
              await _player.seek(seekPostintion);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(foramtTime(postition)),
              IconButton(
                  onPressed: playAction,
                  iconSize: 58,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                  )),
              Text(foramtTime(duration))
            ],
          ),
        ],
      ),
    );
  }

  String foramtTime(Duration value) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigit(value.inHours);
    final min = twoDigit(value.inMinutes.remainder(60));
    final sec = twoDigit(value.inSeconds.remainder(60));
    return [if (value.inHours > 0) hours, min, sec].join(':');
  }
}

class WidgetSondPostFile extends StatefulWidget {
  WidgetSondPostFile({
    required this.postFile,
    super.key,
  });
  final String postFile;
  @override
  State<WidgetSondPostFile> createState() => _WidgetSondPostFileState();
}

class _WidgetSondPostFileState extends State<WidgetSondPostFile> {
  bool isPlaying = false;
  final _player = AudioPlayer();
  double currentSliderValue = 20;

  Duration duration = Duration.zero;
  Duration postition = Duration.zero;
  @override
  void initState() {
    super.initState();
    bindPlayer();
  }

  bindPlayer() async {
    await _player.setUrl(widget.postFile);
    duration = _player.duration!;
    setState(() {});
    _player.positionStream.listen((event) {
      Duration temp = event as Duration;
      postition = temp;
      setState(() {});
    });
  }

  playAction() {
    if (isPlaying) {
      setState(() {});
      _player.pause();
      isPlaying = false;
      print(isPlaying);
    } else {
      setState(() {});
      _player.play();
      isPlaying = true;
      print(isPlaying);
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        children: [
          Slider(
            value: postition.inSeconds.toDouble(),
            min: 0,
            max: duration.inSeconds.toDouble(),
            onChanged: (value) async {
              final seekPostintion = Duration(seconds: value.toInt());
              await _player.seek(seekPostintion);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(foramtTime(postition)),
              IconButton(
                  onPressed: playAction,
                  iconSize: 58,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline,
                  )),
              Text(foramtTime(duration))
            ],
          ),
        ],
      ),
    );
  }

  String foramtTime(Duration value) {
    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigit(value.inHours);
    final min = twoDigit(value.inMinutes.remainder(60));
    final sec = twoDigit(value.inSeconds.remainder(60));
    return [if (value.inHours > 0) hours, min, sec].join(':');
  }
}
