import 'package:flutter/material.dart';
import 'package:topix/commonWidgets/readNewsBottomSheet.dart';
import 'package:topix/secrets/AppInfo.dart';
import 'package:topix/services/utilitiesService.dart';

///this widget render the article

class NewsView extends StatefulWidget {
  final News news;
  NewsView({this.news});
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow()],
              color: Colors.white,
              borderRadius: BorderRadius.circular(8)),
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      widget.news.timeAgo,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              widget.news.imageUrl != null
                  ? Image.network(
                      widget.news.imageUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 1,
                      height: 170,
                    )
                  : Image.network(
                      AppInfo.error_image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 1,
                      height: 170,
                    ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.news.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  widget.news.description != null
                      ? widget.news.description
                      : "News Description",
                  style: TextStyle(),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      //this will open up bottom sheet and load the news page in the bottom sheet itself
                      ReadNews.showBotttomSheet(context, widget.news.url);
                    },
                    child: Text("Read more..."),
                  ),
                  TextButton(
                    onPressed: () {
                      Utility.shareNews(widget.news.imageUrl,
                          widget.news.title + " " + widget.news.url);
                    },
                    child: Text("Share"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Analyze"),
                  )
                ],
              )
            ],
          )),
    );
  }
}
