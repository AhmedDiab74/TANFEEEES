import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/Util/AESEncryption/AES.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiSetGen {
  static Future fetchData() async {
    OfffLineNet();
    var urlSt = accounts[0]['wopllkss'];
    var url = Uri.parse(urlSt);

    try {
      var response =
      await http.post(url, body: {accounts[0]['sm1']: accounts[0]['sm2']});
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await SharedP.Save('configW', responseData['config']);
        var ameno = decryptNewsOkl(responseData['config']);

        GetSetList.add(jsonDecode(ameno));
      }
    } catch (error) {
      print(await SharedP.Get('configW'));
      var ameno2 = decryptNewsOkl(await SharedP.Get('configW'));

      GetSetList.add(jsonDecode(ameno2));
      print('jhjhjhjjh');
    }
  }
}

class ApiListDash {
  static Future fetchData() async {
    var urlSt = accounts[0]['dashlist'];
    var url = Uri.parse(urlSt);

    try {
      var response = await http.post(url,
          body: {accounts[0]['sm1']: accounts[0]['sm2'], 'chek': 'get'});
      var responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        await SharedP.Save('confgW2', responseData['config']);
        var ameno = decryptNewsOkl(responseData['config']);

        dashSettings.add(jsonDecode(ameno));
        print('asdasdasdasdasd ${siteConfig}');
      }
    } catch (e) {
      var ameno2 = decryptNewsOkl(await SharedP.Get('confgW2'));

      dashSettings.add(jsonDecode(ameno2));
    }
  }
}
