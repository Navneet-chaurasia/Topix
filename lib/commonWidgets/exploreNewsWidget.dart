import 'package:flutter/material.dart';
import 'package:topix/commonWidgets/readNewsBottomSheet.dart';
import 'package:topix/services/utilitiesService.dart';

///this widget renders explore page news

class ExplorePageNews extends StatefulWidget {
  final News news;
  ExplorePageNews({this.news});
  @override
  _ExplorePageNewsState createState() => _ExplorePageNewsState();
}

class _ExplorePageNewsState extends State<ExplorePageNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        onTap: () {
          ReadNews.showBotttomSheet(context, widget.news.url);
        },
        title: Text(
          widget.news.title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.news.timeAgo),
      ),
    );
  }
}
