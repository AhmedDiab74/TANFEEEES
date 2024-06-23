import 'package:wowondertimelineflutterapp/FlutterCraftersKey.dart';
import 'package:wowondertimelineflutterapp/SetValue.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/Util/TextUtil.dart';

//test

final nameApp =dashB? siteConfig['siteName']:f_nameApp;

const String ChatGpt_API_KEY =
    "sk-3f2cX1HdOw1Ii3476gVT3BlbkFJ9tNmR9i1SJwYoNaoUA2c";

final onesignalKey = dashB?siteConfig['one_signal_key']:onesignal;
final ChatSystem = dashB?siteConfig['ChatSystem']=='1':f_ChatSystem;
final NodeJS = GetSetList[0]['node_socket_flow'] == '1';
final NodeJs_Port = FixEmptyValue(GetSetList[0]['nodejs_ssl_port'], '4449');
final User_Registration = GetSetList[0]['user_registration'];
final Page_Categories = GetSetList[0]['page_categories'];
final Products_Categories = GetSetList[0]['products_categories'];
final Currency_Array = GetSetList[0]['currency_array'];
final Group_Categories = GetSetList[0]['group_categories'];
final GenderCat = GetSetList[0]['genders'];
final Blog_Categories = GetSetList[0]['blog_categories'];
final Affiliate_System = GetSetList[0]['affiliate_system'];
final Post_Colors = GetSetList[0]['post_colors'];
final ReactionTypes = GetSetList[0]['post_reactions_types'];
final OpenAI_CHATGPT_KEY =
    FixEmptyValue(GetSetList[0]['openai_token'], ChatGpt_API_KEY);

final Default_Currency = CurrencyConverter(GetSetList[0]['currency']);

/// Setting More Options
final Groups = dashB?siteConfig['Groups']=='1':f_Groups;
final MarketPlace = dashB?siteConfig['MarketPlace']=='1':f_MarketPlace;
final Events = dashB?siteConfig['Events']=='1':f_Events;
final Jobs = dashB?siteConfig['Jobs']=='1':f_Jobs;
final Pages = dashB?siteConfig['Pages']=='1':f_Pages;
final Offers = dashB?siteConfig['Offers']=='1':f_Offers;
final Advertising =dashB?siteConfig['Advertising']=='1':f_Advertising;
final Pokes = dashB?siteConfig['Pokes']=='1':f_Pokes;
final Movies = dashB?siteConfig['Movies']=='1':f_Movies;
final Memories = dashB?siteConfig['Memories']=='1':f_Memories;
final Blogs = dashB?siteConfig['Blogs']=='1':f_Blogs;
final Create_Blogs = dashB?siteConfig['Create_Blogs']=='1':f_Create_Blogs;
final Points_System = dashB?siteConfig['Points_System']=='1':f_Points_System;
final bool FriendsFollowers = dashB?siteConfig['Friends_System']=='1':f_FriendsFollowers;
final bool InvitationLinks =dashB?siteConfig['InvitationLinks']=='1':f_InvitationLinks;
final bool Activate_Audio_Calls =dashB?siteConfig['Activate_Audio_Calls']=='1':f_Activate_Audio_Calls;
final bool Activate_Video_Calls =dashB?siteConfig['Activate_Video_Calls']=='1':f_Activate_Video_Calls;

final bool Albums = dashB?siteConfig['Albums']=='1':f_Albums;
final bool SavedPosts =dashB?siteConfig['SavedPosts']=='1':f_SavedPosts;
final bool MyVideo = dashB?siteConfig['MyVideo']=='1':f_MyVideo;
final  bool MyImages = dashB?siteConfig['MyImages']=='1':f_MyImages;
final bool Boosted = dashB?siteConfig['Boosted']=='1':f_Boosted;
final bool Active_Admob_Ads = dashB?siteConfig['Active_Admob_Ads']=='1':f_Active_Admob_Ads;
final bool Active_AdmobBanner = dashB?siteConfig['Active_AdmobBanner']=='1':f_Active_AdmobBanner;
final  bool Reels =dashB?siteConfig['is_Reels']=='1':f_Rreels;
final bool Earnings = dashB?siteConfig['Earnings']=='1':f_Earnings;
final bool Social_Links = dashB?siteConfig['app_social_links']=='1':f_Social_Links;
final bool Social_Login_Page = dashB?siteConfig['app_social_logins']=='1':f_Social_Login_Page;

final  String ADMOB_ANDROID_BANNER_ID = dashB?siteConfig['ADMOB_ANDROID_BANNER_ID']:f_ADMOB_ANDROID_BANNER_ID ;
final String ADMOB_IOS_BANNER_ID =dashB?siteConfig['ADMOB_ANDROID_BANNER_ID']:f_ADMOB_IOS_BANNER_ID ;
final String Agora_App_ID = dashB?siteConfig['Agora_App_ID']:f_Agora_App_ID ;
/// If you want to Add Friend System Then make it true.
final bool Friends_System =  dashB?siteConfig['Friends_System']=='1':f_Friends_System;
//Live Stream plugin WebRTC & RTMP for Wowonder & Sngine Social Network & Playtube
const bool LiveStreamplugin = false;











const bool Enable_Profile_Share = true;

/// Turn on Ads on app





/// 1 for Old Theme, 2 for New Theme
const int Story_Theme_Version = 2;
//seconds 30
const int Story_Max_Upload = 30;

/// Change App icons to Color icons

/// Agora App ID for Calling and LiveStreaming


/// Activate Audio Video Call using agora


/// Activate a conference call for package subscribers
const bool Group_Call_for_Pro_Users = true;

/// The ID of the package in which you want to enable the meeting
const String IdPackageCall = '0';

/// In Next Update

/// RateMyApp Dialogue
const String PackageAndroid = 'app.wowondertimelineflutterappplatform.com';
const String IOSid = '1663370110';



/// To Show or Hide the Social Media Links on Profile


/// To Show or Hide the Social Media Logins Buttons


///Log in with Google || true || false
const bool Login_With_Google = true;

///Log in with Facebook || true || false
const bool Login_With_Facebook = true;

///login with Apple
const bool Login_With_Apple = true;

///The number of publications that are fetched in the main screen in each update
const String Home_Post_Limit = '20';

//The number of people you may know
const String Recommended_friend = '50';

///true false copy text
const bool Copy_Post_Text = true;

///ffmpeg
const bool FFmpeg = true;

//The running time of the video in the story

////Timer Resend Code OTP
//seconds 30
const int OTP_Resend_Timer = 30;

//social login go
const String ClientIdGoogleIos =
    '954615029850-l2v45oenqocai4hqeralprh2inqvorlu.apps.googleusercontent.com';

/// Checks if string is an video file.
///       ext.endsWith(".avi") ||
/// Video playback formats have been added here
bool VideoEx(String filePath) {
  var ext = filePath.toLowerCase();

  return ext.endsWith(".mp4") ||
      ext.endsWith(".avi") ||
      ext.endsWith(".wmv") ||
      ext.endsWith(".rmvb") ||
      ext.endsWith(".mpg") ||
      ext.endsWith(".mov") ||
      ext.endsWith(".mpeg") ||
      ext.endsWith(".3gp");
}

// bool pdf(String filePath) {
//   var ext = filePath.toLowerCase();

//   return ext.endsWith(".pdf");
// }

// final CurrencyLength = GetSetList[0]['currency_symbol_array'].length.toString();

String keyWowo = FlutterCraftersKey;




