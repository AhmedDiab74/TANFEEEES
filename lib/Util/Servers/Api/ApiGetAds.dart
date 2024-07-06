import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/AdsModel.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';

class ApiGetAds {
  static Future<List<AdsModel>> getAds(
    String ads_id,
  ) async {
    var url = Uri.parse(accounts[0]['ads'] + await SharedP.Get('tok'));
    var dir = await getTemporaryDirectory();

    List<AdsModel> posts = <AdsModel>[];


      var response = await http.post(url, body: {
           accounts[0]['sm1']: accounts[0]['sm2'],
        'type': 'fetch_ad_by_id',
        'ad_id': ads_id
      });

      var resp = response.body;

      var datajson = jsonDecode(resp);
      var wwwdata = datajson['data'];

    
        posts.add(AdsModel.fromJson(wwwdata));
      

      return posts;
   
}
}