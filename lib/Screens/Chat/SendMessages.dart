import 'package:wowondertimelineflutterapp/String.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSendMessages.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/SnedMessagesAjax.dart';

class SendMessages {
  static Send({
    required String user_id,
    required String gif,
    required String text,
    required filename,
    required file,
  }) {
    if (NodeJS) {
      //true nodejs
    } else {
      //false nodejs
      print(filename);
      SnedMessagesAjax.send(
          user_id: user_id,
          text: text,
          gif: gif,
          file: file,
          filename: filename);
    }
  }
}


                                        // if (ImagePost == null)
                                        //   if (audioPath == null)
                                        //     InkWell(
                                        //         onTap: () {
                                        //           if (text.isNotEmpty)
                                        //             sendComments();
                                        //           for (var i = 0;
                                        //               i <
                                        //                   getimydata
                                        //                       .data.length;
                                        //               i++)
                                        //             SocketNew.sendmessageSoket(
                                        //                 widget.userid,
                                        //                 getimydata
                                        //                     .data[i].username,
                                        //                 text,
                                        //                 false,
                                        //                 '');

                                        //           setState(() {
                                        //             text = '';
                                        //           });
                                        //         },
                                        //         child: Container(
                                        //           padding: EdgeInsets.all(10),
                                        //           child: Change_Color_Icons
                                        //               ? SvgPicture.asset(
                                        //                   ColorSvg.SendMessage,
                                        //                   color:
                                        //                       Change_Color_Icons
                                        //                           ? null
                                        //                           : ColorTheme,
                                        //                   // color: Color.fromARGB(255, 255, 255, 255),
                                        //                   width: 40,
                                        //                   height: 40,
                                        //                 )
                                        //               : SvgPicture.asset(
                                        //                   'assets/svg/chat/send-svgrepo-com.svg',
                                        //                   color: Get.isDarkMode
                                        //                       ? Colors.white
                                        //                       : Colors.black),
                                        //         )),
                                        // if (audioPath != null)
                                        //   InkWell(
                                        //       onTap: () async {
                                        //         _sendMessgAudio(audioPath);
                                        //         SocketNew.sendMessgaSoketMedia(
                                        //             widget.userid,
                                        //             audioPath,
                                        //             _filename,
                                        //             'audio');

                                        //         final path =
                                        //             await audioRecord.stop();
                                        //         setState(() {
                                        //           if (path != null) {
                                        //             audioPath = null;
                                        //             path != null;
                                        //             _recordDuration == 0;
                                        //           }
                                        //         });
                                        //       },
                                        //       child: SvgPicture.asset(
                                        //         'assets/svg/chat/send-svgrepo-com.svg',
                                        //       )),
                                        // if (ImagePost != null)
                                        //   InkWell(
                                        //       onTap: () async {
                                        //         _sendMessgAudio(
                                        //             ImagePost!.path);
                                        //         SocketNew.sendMessgaSoketMedia(
                                        //             widget.userid,
                                        //             ImagePost!.path,
                                        //             'image',
                                        //             'image');

                                        //         setState(() {
                                        //           if (ImagePost != null) {
                                        //             ImagePost = null;
                                        //           }
                                        //         });
                                        //         get();
                                        //       },
                                        //       child: SvgPicture.asset(
                                        //           'assets/svg/chat/send-svgrepo-com (1).svg'))
                                      