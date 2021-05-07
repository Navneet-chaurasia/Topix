import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:topix/commonWidgets/newsView.dart';
import 'package:topix/services/getNewsService.dart';
import 'package:topix/services/utilitiesService.dart';

///for you page of the app
///will display news of your choice

class ForYouPage extends StatefulWidget {
  @override
  _ForYouPageState createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage>
    with AutomaticKeepAliveClientMixin {
  List<News> news_list = [];
  bool loading = true;
  bool moreNewsLoading = false;
  int _choiceIndex = 1;
  int page = 1;
  String category = "";

  @override
  void initState() {
    getNewsList();
    super.initState();
  }

  ///this method fetch news from api
  ///category = all
  ///country = india (by default);
  getNewsList() async {
    page = 1;
    setState(() {
      loading = true;
    });
    news_list = await NewsGet.getArticlesFromNetwork("in", category, page);
    setState(() {
      loading = false;
    });
  }

  ///method to load more news
  ///this will increment page count and add more news into the news_list
  loadMoreNews() async {
    page++;
    print(page);
    setState(() {
      moreNewsLoading = true;
    });
    news_list.addAll(await NewsGet.getArticlesFromNetwork("in", category, page)
        .catchError((onError) {
      print(onError);
    }));
    setState(() {
      moreNewsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SingleChildScrollView(
          child: chipList(),
          scrollDirection: Axis.horizontal,
        ),
        Expanded(
          child: loading == true
              ? SpinKitChasingDots(color: Colors.black)
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == news_list.length) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              loadMoreNews();
                            },
                            child: moreNewsLoading
                                ? SpinKitPulse(
                                    color: Colors.black,
                                  )
                                : Text("Load more...")),
                      );
                    } else
                      return NewsView(news: news_list[index]);
                  },
                  itemCount: news_list.length + 1),
        ),
      ],
    );
  }

  Widget chipList() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: List.generate(categories.length, (index) {
          return _buildChip(categories[index], Colors.white, index);
        })));
  }

  /// build chips
  Widget _buildChip(String label, Color color, index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ChoiceChip(
        selectedColor: Colors.lightBlueAccent,
        selected: label == "Refresh" ? false : _choiceIndex == index,
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: color,
        elevation: 2.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(8),
        onSelected: (bool selected) {
          setState(() {
            if (label == "Refresh") {
              getNewsList();
            } else {
              if (_choiceIndex == index) {
                return;
              }
              _choiceIndex = selected ? index : 0;
              setState(() {
                if (categories[index] == "For You") {
                  category = "";
                } else
                  category = categories[index];
              });
              getNewsList();
            }
          });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
