import 'package:flutter/material.dart';
import 'package:topix/commonWidgets/readNewsBottomSheet.dart';
import 'package:topix/services/getNewsService.dart';
import 'package:topix/services/utilitiesService.dart';

///this widget is for showing search bar

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String query = "";
  List<News> news = [];

  ///method for searching news
  search() async {
    if (query == "") {
      return;
    }

    news = await NewsGet.getSearchedNews(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Theme(
            data: ThemeData(primaryColor: Colors.blue),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Search News"),
                    onChanged: (q) {
                      query = q;
                    },
                    onSubmitted: (q) {
                      search();
                    },
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      search();
                    })
              ],
            ),
          ),
          elevation: 0,
        ),
        body: showNews());
  }

  ///widget to show searched news
  Widget showNews() {
    return news.length == 0
        ? Center(
            child: Text("Search News..."),
          )
        : ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: ListTile(
                  onTap: () {
                    ReadNews.showBotttomSheet(context, news[index].url);
                  },
                  title: Text(news[index].title),
                  subtitle: Text(news[index].timeAgo),
                ),
              );
            },
            itemCount: news.length,
          );
  }
}
