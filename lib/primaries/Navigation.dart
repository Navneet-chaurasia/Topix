import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:topix/Auth/UserInfo.dart';
import 'package:topix/commonWidgets/drawer.dart';

///## this is navigation widget
/// **top widget for everything**
/// _It will have a an appbar_,
/// bottomNavigatio with 4 actions ,
/// and a drawer for more options
class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  ///is user info loaded
  bool isUserInfoLoaded = false;

  int _selectedIndex = 0;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    await TopixUserInfo.intializeUser(context);
    print("hii");
    setState(() {
      isUserInfoLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isUserInfoLoaded == false
        ? SpinKitWave(color: Colors.black)
        : DefaultTabController(
            length: 4,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: Align(
                    alignment: Alignment.centerRight, child: Text("Topix")),
                elevation: 0,
              ),
              drawer: TopixDrawer(),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Text(
                    'For You',
                  ),
                  Text(
                    'Search',
                  ),
                  Text(
                    'Topics',
                  ),
                  Text(
                    'Me',
                  ),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: TabBar(
                  onTap: (i) {
                    //Utilities.temp();
                  },
                  tabs: <Widget>[
                    Tab(
                      icon: new Icon(Icons.home),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.search,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.topic,
                        size: 35,
                      ),
                    ),
                    Tab(icon: Icon(Icons.account_circle)),
                  ],
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.transparent,
                ),
              ),
            ));
  }
}
