import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:topix/Auth/UserInfo.dart';
import 'package:topix/commonWidgets/drawer.dart';
import 'package:topix/screens/ExploreNews.dart';
import 'package:topix/screens/fake_news_detector.dart';
import 'package:topix/screens/forYouPage.dart';

///## this is navigation widget
/// **top widget for everything**
/// _It will have a an appbar_,
/// bottomNavigatio with 4 actions ,
/// and a drawer for more options
class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with AutomaticKeepAliveClientMixin {
  ///is user info loaded
  bool isUserInfoLoaded = false;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    setState(() {
      isUserInfoLoaded = false;
    });
    await TopixUserInfo.intializeUser(context);
    //print("hii");
    setState(() {
      isUserInfoLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isUserInfoLoaded == false
        ? SpinKitWave(color: Colors.black)
        : DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Topix"),
                elevation: 0,
                centerTitle: true,
              ),
              // drawer: TopixDrawer(),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ForYouPage(),
                  FNDetector(),
                  ExploreNews(),
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
                  ],
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.transparent,
                ),
              ),
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
