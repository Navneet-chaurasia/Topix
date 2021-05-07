import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:topix/commonWidgets/exploreNewsWidget.dart';
import 'package:topix/services/getNewsService.dart';
import 'package:topix/services/utilitiesService.dart';

///for you page of the app
///will display news of your choice

class ExploreNews extends StatefulWidget {
  @override
  _ExploreNewsState createState() => _ExploreNewsState();
}

class _ExploreNewsState extends State<ExploreNews>
    with AutomaticKeepAliveClientMixin {
  List<News> news_list = [];
  bool loading = true;

  @override
  void initState() {
    getNewsList();
    super.initState();
  }

  ///this method fetch news from api
  ///category = all
  ///country = india (by default);
  getNewsList() async {
    setState(() {
      loading = true;
    });
    news_list = await NewsGet.getLocalNewsFromNetwork();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        searchBar(),
        Expanded(
          child: loading == true
              ? SpinKitChasingDots(color: Colors.black)
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ExplorePageNews(news: news_list[index]);
                  },
                  itemCount: news_list.length),
        ),
      ],
    );
  }

  //search bar
  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/search');
        },
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(50)),
          child: Center(
              child: Text(
            "Search news...",
            style: TextStyle(fontSize: 15),
          )),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
