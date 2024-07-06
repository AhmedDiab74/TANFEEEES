import 'package:wowondertimelineflutterapp/main.dart';


import 'package:socket_io_client/socket_io_client.dart';




class newnewSok {
  static Socket socketss = io(
      accounts[0]['hosts'],
      OptionBuilder()
          .setPath('/socket.io')
          .setTransports(['websocket']).build());

  static onncteSokets() async {
    socketss.connect();
  }
}
