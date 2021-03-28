import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///this class contains some static fields and method related to user data
///like getting, setting user data
///
///
class TopixUserInfo {
  static String userName;
  static String userid;
  static String userEmail;
  static String userPic;
  static bool loginStatus = false;
  static String bio;

  ///method to initialize userInfo

  static intializeUser(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;

    if (user == null) {
      loginStatus = false;

      return true;
    } else {
      loginStatus = true;
      userid = user.uid;

      return await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          userName = value.data()['username'];
          userid = value.data()['userid'];
          userEmail = value.data()['email'];
          userPic = value.data()['userPic'];

          bio = value.data()['bio'];

          return true;
        } else {
          //if user has been deleted by admins or whatever although his data exists in database
          //still set login = false;

          loginStatus = false;
          return true;
        }
      });
    }
  }
}