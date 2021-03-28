import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:topix/Auth/AuthBottomsSheet.dart';
import 'package:topix/Auth/UserInfo.dart';

///this is a drawer of app with some actions
class TopixDrawer extends StatefulWidget {
  @override
  _TopixDrawerState createState() => _TopixDrawerState();
}

class _TopixDrawerState extends State<TopixDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TopixUserInfo.loginStatus
                ? UserAccountsDrawerHeader(
                    accountName: Text(TopixUserInfo.userName),
                    accountEmail: Text(TopixUserInfo.userEmail),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(TopixUserInfo.userPic),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 50),
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign in with Google",
                      onPressed: () async {
                        TopixAuth.showBotttomSheet(context);
                      },
                    ),
                  ),
            ListTile(
              title: Text("Option 1 "),
            ),
            ListTile(
              title: Text("Option 1 "),
            ),
            ListTile(
              title: Text("Option 1 "),
            ),
            ListTile(
              title: Text("Option 1 "),
            ),
            ListTile(
              title: Text("Option 1 "),
            ),
            Divider(),
            ListTile(
              title: Text("Settings"),
            ),
            ListTile(
              title: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
