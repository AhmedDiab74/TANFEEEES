import 'dart:async';
import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_emoji_gif_picker/giphy/models/languages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/CreaePostImageApi.dart';
import 'package:flutter_social_textfield/flutter_social_textfield.dart';

class CreatePostCont extends GetxController {
  bool records = false;
  // final record = FlutterSoundRecorder();
  // StreamSubscription<SocialContentDetection>? _streamSubscription;
  SocialTextEditingController textEditingController =
      SocialTextEditingController();
  final TextEditingController poll1 = TextEditingController();
  final TextEditingController poll2 = TextEditingController();
  final TextEditingController poll3 = TextEditingController();
  final TextEditingController poll4 = TextEditingController();
  final TextEditingController poll5 = TextEditingController();
  final TextEditingController poll6 = TextEditingController();
  final TextEditingController poll7 = TextEditingController();
  final TextEditingController poll8 = TextEditingController();
  final TextEditingController smaileicon = TextEditingController();
  final TextEditingController smailetext = TextEditingController();
  final TextEditingController backRound = TextEditingController();
  final TextEditingController postMapText = TextEditingController();
  final TextEditingController travlintext = TextEditingController();

  bool postMap = false;
  String? postTr;

  String? Page_id;
  final ImagePicker picker = ImagePicker();
  XFile? ImagePost;
  List<XFile> imageFileList = [];
  XFile? videoUp;
  String? filename;
  bool isLoding = false;
  RxBool truefalsecolor = false.obs;
  RxString colorId = '0'.obs;
  bool true2 = true;
  void cleare() {
    textEditingController.clear();
    poll1.clear();
  }
  //gif

  void removeGif() {
    gifs = null;
    sendgif = null;
    update();
  }

  GiphyGif? gifs;
  String? sendgif;
  GifUpode(context) async {
    final gif = await GiphyPicker.pickGif(
      showPreviewPage: false,
      sticker: true,
      context: context,
      apiKey: '420d477a542b4287b2bf91ac134ae041',
    );

    // print(gif);
    if (gif != null) {
      gifs = gif;
      sendgif = gif.images.original?.url;
      update();
      Get.back();
    }
  }

  @override
  void onInit() {
    ameen();
    _getDir();

    _initialiseControllers();
    super.onInit();
  }

  Future<void> truefalseopen(bool trueflase) async {
    truefalsecolor.value = await false;
    truefalsecolor.value = await trueflase;
    update();
  }

  voidColorId(String id) {
    colorId.value = id;
    update();
  }

  updateTr(d) {
    postTr = d;
    update();
    if (d != null) {
      Get.back();
    }
  }

  updatePostMap(t) {
    postMap = t;
    update();
  }

  void ameen() {
    textEditingController = SocialTextEditingController()
      ..text = textEditingController.text
      ..setTextStyle(
          DetectedType.mention,
          TextStyle(
              color: Colors.purple,
              backgroundColor: Colors.purple.withAlpha(50)))
      ..setTextStyle(DetectedType.url,
          TextStyle(color: Colors.blue, decoration: TextDecoration.underline))
      ..setTextStyle(DetectedType.hashtag,
          TextStyle(color: Colors.blue, fontWeight: FontWeight.w600));

    textEditingController.subscribeToDetection(onDetectContent);
  }

  int cont = 0;
  void onDetectContent(SocialContentDetection detection) {
    if (detection.text ==
        '@') {} // if (detection.type.toString() == 'DetectedType.mention') {
    //   cont++;
    //   update();
    // }
    detection.type.toString();
  }

  void IsLoding() {
    isLoding = !isLoding;
    update();
  }

  // Future recored() async {
  //   await record.startRecorder(toFile: 'audio');
  //   records = true;
  //   update();
  // }

  // Future stoprecord() async {
  //   await record.stopRecorder();
  //   records = false;
  //   update();
  //   onClose() {
  //     record.closeAudioSession();
  //     super.onClose();
  //   }
  // }

  void selectimges() async {
    final List<XFile>? selectedImages = await picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      update();
    }
  }

  void reomveSelected(index) {
    imageFileList.removeAt(index);
    update();
  }

  Future<void> vedioupolde(send) async {
    await Permission.storage.request();
    await Permission.photos.request();

    final XFile? video = await picker.pickVideo(source: send);

    videoUp = video;
    filename = videoUp!.path.split('/').last;
    Get.back();
    update();
  }

  Future<void> UplodeImage(send) async {
    await Permission.storage.request();
    await Permission.photos.request();
    final XFile? image = await picker.pickImage(source: send);
    ImagePost = image;
    Get.back();
    update();
  }

  String? recor;
  String? pathRecord;
  String? musicFile;
  String? nameFilee;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  late Directory appDirectory;
  late final RecorderController recorderController;
  bool recordsCreate = false;
  void updateRecore(bool to) {
    recordsCreate = to;
    isRecordingCompleted = false;
    pathRecord = null;
    update();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();

    isLoading = false;
    update();
  }

  void _initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void startOrStopRecording() async {
    isRecordingCompleted = false;
    update();
    try {
      if (isRecording) {
        recorderController.reset();

        pathRecord = await recorderController.stop(false);

        if (pathRecord != null) {
          isRecordingCompleted = true;
          debugPrint(pathRecord);
          debugPrint("Recorded file size: ${File(pathRecord!).lengthSync()}");
          // await record.start(const RecordConfig(), path: pathRecord!);

          // print(stream);
        }
      } else {
        await recorderController.record(
          path: pathRecord,
        ); // Path is optional
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRecording = !isRecording;
      update();
    }

    void _refreshWave() {
      if (isRecording) recorderController.refresh();
    }
  }

  void removeFile() {
    nameFilee = null;
    musicFile = null;
    update();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile = result.files.single.path;
      nameFilee = result.files.single.name;

      update();
    } else {
      debugPrint("File not picked");
    }
  }

  void CreatPost(
    postPrivacy,
  ) async {
    CreatePostImageApi.cratepost(
      pathimage: ImagePost != null ? ImagePost!.path : null,
      pathvideo: videoUp != null ? videoUp!.path : null,
      text: textEditingController.text,
      filename: filename,
      postPrivacy: postPrivacy,
      poll1: poll1.text,
      poll2: poll2.text,
      poll3: poll3.text,
      poll4: poll4.text,
      poll5: poll5.text,
      poll6: poll6.text,
      poll7: poll7.text,
      poll8: poll8.text,
      feeling_type: smailetext.text,
      pathpostPhotos: imageFileList,
      group_id:
          Get.arguments == null ? '' : Get.arguments['group_id'].toString(),
      page_id: Get.arguments == null ? '' : Get.arguments['page_id'].toString(),
      color: backRound.text,
      postMap: postMap,
      postMapText: postMapText.text,
      travlin: postTr,
      travlintext: travlintext.text,
      gifs: sendgif,
            audioRecord: musicFile ?? pathRecord,

    );

    // ImagePost != null ? ImagePost!.path : null,
    //       videoUp != null ? videoUp!.path : null,
    //       textEditingController.text,
    //       filename,
    //       postPrivacy,
    //       poll1.text,
    //       poll2.text,
    //       poll3.text,
    //       poll4.text,
    //       poll5.text,
    //       poll6.text,
    //       poll7.text,
    //       poll8.text,
    //       smailetext.text,
    //       imageFileList,
    //       Get.arguments == null ? '' : Get.arguments['group_id'].toString(),
    //       Get.arguments == null ? '' : Get.arguments['page_id'].toString(),
    //       backRound.text
    update();
  }
}
