import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:topix/Auth/AuthServices.dart';
import 'package:topix/Auth/UserInfo.dart';
import 'package:topix/primaries/Navigation.dart';
import 'package:topix/secrets/AppInfo.dart';

///this class contains static method to show bottom sheet
class TopixAuth {
  static void showBotttomSheet(BuildContext context) {
    showModalBottomSheet(
        elevation: 8.0,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return TopixUserInfo.loginStatus == false
              ? TopixAuthBottomSheet()
              : Center(child: Text("Already logged in"));
        });
  }
}

///Auth bottom sheet
///when user will press Signup button this Bottom sheet will appear from nowhere and will fuck the user
///

class TopixAuthBottomSheet extends StatefulWidget {
  @override
  _TopixAuthBottomSheetState createState() => _TopixAuthBottomSheetState();
}

class _TopixAuthBottomSheetState extends State<TopixAuthBottomSheet> {
  bool signup = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                  child: Center(
                    child: Text(
                      "Sign up For " + AppInfo.appName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        wordSpacing: -2,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                child: Center(
                    child: Text(
                  "Create a profile, follow Topics, debates and much more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.blueGrey),
                )),
              ),

              // with custom text
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20, top: 10, bottom: 100),
                child: Center(
                    child: SignInButton(
                  Buttons.Google,
                  text: "continue with Google",
                  onPressed: () async {
                    setState(() {
                      _loading = !_loading;
                    });
                    if (await AuthServices.signInWithGoogle(context)) {
                      Navigator.of(context).pushAndRemoveUntil(
                          new MaterialPageRoute(
                              builder: (BuildContext context) {
                        return Navigation();
                      }), (Route<dynamic> route) => false);
                    }

                    setState(() {
                      _loading = !_loading;
                    });
                  },
                )),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                "By continuing, you agree to ${AppInfo.appName}'s ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.black26)),
                        TextSpan(
                            text: 'policies and terms.',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_loading)
            SpinKitCircle(
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}
