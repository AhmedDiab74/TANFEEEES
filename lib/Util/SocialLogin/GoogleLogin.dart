import 'dart:io';
import 'package:get/get.dart';
import 'package:wowondertimelineflutterapp/main.dart';
import 'package:wowondertimelineflutterapp/String.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wowondertimelineflutterapp/ThemesWoWonder.dart';
import 'package:googleapis/people/v1.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wowondertimelineflutterapp/Screens/NavBar/HomeNavBar.dart';
import 'package:wowondertimelineflutterapp/Screens/AuthScreen/NameScreen.dart';
import 'package:wowondertimelineflutterapp/controllers/SharedPreferences.dart';
import 'package:wowondertimelineflutterapp/Util/Servers/Api/ApiSocialLogin.dart';

class SignInDemo2 extends StatefulWidget {
  const SignInDemo2({super.key});

  @override
  State<SignInDemo2> createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo2> {
  _signinWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn(
        clientId:
            Platform.isIOS ? ClientIdGoogleIos : GetSetList[0]['googleAppId'],
        scopes: [
          'email',
        ]
        // forceCodeForRefreshToken: true,
        ).signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    print('authHeaders ${gUser.email.toString()}');
    print('idToken  ${gAuth.idToken}');
    print('ameenjawadhamed  ${gAuth.accessToken}');
    Login_With_Google;
    if (gAuth.idToken.toString().isNotEmpty) {
      var tok = await ApiSocialLogin.lgin('google', gAuth!.idToken.toString());
      print(tok.toString());
      if (tok['is_new']) {
        SharedP.Save('tok', tok['access_token'].toString());
        SharedP.Save('user_id', tok['user_id'].toString());
        Get.offAll(NameScreen());
        print('new');
      } else {
        SharedP.Save('tok', tok['access_token'].toString());
        SharedP.Save('user_id', tok['user_id'].toString());
        Get.offAll(HomeNavBar());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _signinWithGoogle,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            border: Border.all(
                color: Get.isDarkMode ? ColorDarkComponents : Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Get.isDarkMode ? ColorDarkComponents : Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/google.png',
                height: 20,
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Authentication {
//   static Future<User?> signInWithGoogle({required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           // handle the error here
//         } else if (e.code == 'invalid-credential') {
//           // handle the error here
//         }
//       } catch (e) {
//         // handle the error here
//       }
//     }

//     return user;
//   }
// }
