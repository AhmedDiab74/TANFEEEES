bool dashB = false;
final f_nameApp = 'Wowonder Flutter';

final bool f_ChatSystem = true;
final bool f_Movies = true;
final bool f_FriendsFollowers = true;
final bool f_Groups = true;
final bool f_MarketPlace = true;
final bool f_Events = true;
final bool f_Jobs = true;
final bool f_Pages = true;
final bool f_Offers = true;
final bool f_Advertising = true;
final bool f_Pokes = true;
final bool f_Memories = true;
final bool f_Blogs = true;
final bool f_Create_Blogs = true;
final bool f_Points_System = true;
final bool f_InvitationLinks = true;
final bool f_Activate_Audio_Calls = true;
final bool f_Activate_Video_Calls = true;
final bool f_Albums = true;
final bool f_SavedPosts = true;
final bool f_MyVideo = true;
final bool f_MyImages = true;
final bool f_Boosted = true;
final bool f_Active_Admob_Ads = true;
final bool f_Active_AdmobBanner = true;
final bool f_Rreels = true;
final bool f_Earnings = true;
final bool f_Social_Links = true;
final bool f_Social_Login_Page = true;

/// If you want to Add Friend System Then make it true.
final bool f_Friends_System = false;
const String onesignal = 'f9e16221-bc9f-4d71-8001-a48d611b8940';

/// Make you change the App Id in AndroidManifest.xml
/// Android Banner ID
final String f_ADMOB_ANDROID_BANNER_ID =
    'ca-app-pub-5148326721676561/5665441234';

/// iOS Banner ID
final String f_ADMOB_IOS_BANNER_ID = 'ca-app-pub-5148326721676561/5665441234';

final String f_Agora_App_ID = '6a1fcb8a44454844a9b46b271d637e7f';

bool isFile(String filePath) {
  final ext = filePath.toLowerCase();

  return ext.endsWith(".rar") ||
      ext.endsWith(".zip") ||
      ext.endsWith(".tar") ||
      ext.endsWith(".exe") ||
      ext.endsWith(".apk") ||
      ext.endsWith(".apk") ||
      ext.endsWith(".abb");
}
