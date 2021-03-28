import 'package:flutter/material.dart';

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
            UserAccountsDrawerHeader(
              accountName: Text("Navneet chaurasia"),
              accountEmail: Text("Navneetc486@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "N",
                  style: TextStyle(fontSize: 40.0),
                ),
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
