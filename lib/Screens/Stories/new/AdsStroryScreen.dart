import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/Screens/Pages/HomePagesScreen.dart';
import 'package:wowondertimelineflutterapp/Util/Functions.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiGetAds.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Models/AdsModel.dart';

class GetAdsStory extends StatefulWidget {
  const GetAdsStory({
    super.key,
    required this.ad_id,
  });
  final String ad_id;

  @override
  State<GetAdsStory> createState() => _GetAdsStoryState();
}

class _GetAdsStoryState extends State<GetAdsStory> {
  List<AdsModel> data = [];
  Getdata() async {
    ApiGetAds.getAds(widget.ad_id).then((value) {
      setState(() {
        data = value.toList();
      });
    });
  }

  @override
  void initState() {
    Getdata();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        for (var i = 0; i < data.length; i++)
          InkWell(
            onTap: (){
              GoUrl(data[i].url);
            },
            child: Center(
              child: CachedNetworkImage(
                imageUrl: data[i].ad_media.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        for (var i = 0; i < data.length; i++)
          Positioned(
              bottom: sizedHeight(context) * 0.20,
              left: 5,
              right: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data[i].description,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )),
              )),
              for (var i = 0; i < data.length; i++)
          Positioned(
              top: sizedHeight(context) * 0.20,
              left: 10,
 
              child: InkWell(
                onTap: (){
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            data[i].url.replaceAll('https://', '').replaceAll('http://', '').replaceAll('wwww', ''),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                                      
                          ),
                SizedBox(width: 5,),
                          Icon(Icons.open_in_browser_outlined,color: Colors.white,)
                        ],
                      ),
                    )),
              )),
      ],
    );
  }
}
