import 'dart:convert';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';

class ApiCommentLive {
  static Future CreateComments(
      String post_id, text, imageasset, String type) async {
    var headers = {
      'Cookie':
          '_us=1719563141; ad-con=%7B%26quot%3Bdate%26quot%3B%3A%26quot%3B2024-06-27%26quot%3B%2C%26quot%3Bads%26quot%3B%3A%5B%5D%7D; PHPSESSID=c64590f56ebba7abf45a245b693ab041; _us=1718820127; ad-con=%7B%26quot%3Bdate%26quot%3B%3A%26quot%3B2024-06-18%26quot%3B%2C%26quot%3Bads%26quot%3B%3A%5B%5D%7D; mode=day; src=1'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://wowonder.fluttercrafters.com/api/ads?access_token=52e7d1ac9d7205434fcd495ee8974851861e0d4dca4c5790b5c2df4da3299ec86dbb95cb5836663084cb17743002b4cfb81b0153cee648fc'));
    request.fields.addAll({
      'server_key': 'd1283b82c0fd79aabbe18003dcc51adb',
      'type': 'create',
      'name': 'nnnnnnnnnnnnnnnnnnnnnn',
      'website': 'http://localhost:8012/wowonder/ads/create/',
      'headline': 'nnnnnnnnnnnnnnnnnnnnn',
      'description': 'nnnnnnnnnnnnnnnnnn',
      'bidding': 'clicks',
      'appears': 'post',
      'audience-list':
          '0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,238,239,240,241,242,243',
      'gender': 'all',
      'location': 'istanbul',
      'page': 'vvvvvvvvvvvvvvvv',
      'start': '2023-03-1',
      'end': '2025-04-23',
      'budget': '1'
    });
    request.files.add(await http.MultipartFile.fromPath(
        'media', '/Users/amin/Desktop/mywebsite/assets/icon.png'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
   var ameen = await response.stream.bytesToString();
      var jsonD = jsonDecode(ameen);
      return jsonD;
    } else {
      print(response.reasonPhrase);
    }
  }
}
