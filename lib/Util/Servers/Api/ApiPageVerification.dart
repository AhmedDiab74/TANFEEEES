import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/main.dart';


// TextEditingController company = TextEditingController();
// TextEditingController address = TextEditingController();
// TextEditingController phone = TextEditingController();
// TextEditingController website = TextEditingController();
// TextEditingController about = TextEditingController();
class ApiUpdatePage {
  static Future upd({
    required String page_id,
    facebook,
    twitter,
    instgram,
    vk,
    linkedin,
    youtube,
    company,
    address,
    phone,
    website,
    about,
    page_category,
    page_name,
    page_title,
    call_action_type_url,
    users_post,
    call_action_type_text,
  }) async {
    var url = Uri.parse(accounts[0]['updp']  + await SharedP.Get('tok'));
    var response = await http.post(url, body: {
           accounts[0]['sm1']: accounts[0]['sm2'],
           accounts[0]['pgid']: page_id,
      if (page_name != null) 'page_name': page_name,
      if (page_title != null) 'page_title': page_title,
      if (call_action_type_url != null)
        'call_action_type_url': call_action_type_url,
      if (users_post != null) 'users_post': users_post,
      if (page_category != null) 'page_category': page_category,
      if (call_action_type_text != null)
        'call_action_type': call_action_type_text,

      //profile Seetings
      if (company != null) 'company': company.toString(),
      if (address != null) 'address': address.toString(),
      if (phone != null) 'phone': phone.toString(),
      if (website != null) 'website': website.toString(),
      if (about != null) 'page_description': about.toString(),

      //profile Seetings///

      //******************************* */

      //social
      if (facebook != null) 'facebook': facebook,
      if (twitter != null) 'twitter': twitter,
      if (instgram != null) 'instgram': instgram,
      if (vk != null) 'vk': vk,
      if (linkedin != null) 'linkedin': linkedin,
      if (youtube != null) 'youtube': youtube,
      //socail
      //************************* */
    });

    var resp = response.body;
    print(resp);
    var jsons = jsonDecode(resp);

    if (jsons['api_status'] == 200) {
      return jsons;
    } else {
      return jsons;
    }
  }
}

class ApiPageVerification {
  static Future ver({
    required String page_id,
  }) async {
     var url = Uri.parse(accounts[0]['verP']  + await SharedP.Get('tok'));

    var response =
        await http.post(url, body: {   accounts[0]['sm1']: accounts[0]['sm2'],
           accounts[0]['pgid']: page_id,});

    var resp = response.body;

    var json = jsonDecode(resp);

    if (json['api_status'] == 200) {
      return json;
    } else {
      return json;
    }
  }
}
