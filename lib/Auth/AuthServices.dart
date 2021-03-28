import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topix/primaries/Navigation.dart';

import 'UserInfo.dart';

///this class is resposible for Auth related activities
///1. login
///2. signup
///3. logout, and others
///
///This class contains some static method
class AuthServices {
  ///signin with google
  static signInWithGoogle(context) async {
    try {
      GoogleSignIn googleSignIn = new GoogleSignIn();
      FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);

      await setUser();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  ///reset password service
  //method for reset password
  static resetPassword(String email) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);

      Fluttertoast.showToast(
          msg: "emial has sent!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          textColor: Colors.white,
          fontSize: 16.0);
      return true;
    } catch (e) {
      if (e.code == "ERROR_USER_NOT_FOUND") {
        Fluttertoast.showToast(
            msg: "this email is not registered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "error occurred, try again later!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      return false;
    }
  }

  ///logout method
  static void logout(context) async {
    //set isLoggedIn false
    TopixUserInfo.loginStatus = false;

    GoogleSignIn googleSignIn = new GoogleSignIn();
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    await googleSignIn.signOut();

    await TopixUserInfo.intializeUser(context);

//I am calling main method , so that app will be restarted
//i dont know if it is a right practice

    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Navigation();
    }), (Route<dynamic> route) => false);
  }

  ///this will set user data in database (firestore)
  static setUser() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;

      User user = auth.currentUser;

      String email = user.email;
      String uid = user.uid;
      String username = user.displayName;
      String userPic = user.photoURL;

      //set this user into firestore
      //check if this user not exist already

      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get()
          .then((onValue) async {
        if (!onValue.exists) {
          await onValue.reference.set({
            'userid': uid,
            'email': email,
            'username': username,
            'userPic': userPic,
            'bio': "No bio",
            'isOnline': true,
            'joinedAt': DateTime.now().millisecondsSinceEpoch,
          });
        }
      });

      await TopixUserInfo.intializeUser(BuildContext);

      return true;
    } catch (e) {
      print(e.toString());
    }
  }
}
