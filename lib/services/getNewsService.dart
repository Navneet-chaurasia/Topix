import 'dart:convert';
import 'package:topix/secrets/AppInfo.dart';

import 'utilitiesService.dart';
import 'package:http/http.dart' as http;

///this file contains class => NewsGet
/// NewsGet class contains some static methods to retrive news from api

class NewsGet {
  static Future<List<News>> getArticlesFromNetwork(
      country, category, page) async {
    List<News> articles = [];
    try {
      final response =
          await http.get(Uri.parse(Utility.formatUrl(country, category, page)));

      if (response.statusCode == 200) {
        articles = Utility.parseNews(response.body);
      }
    } catch (e) {
      print('=== API::getArticlesFromNetwork Error ${e.toString()}');
    }
    return articles;
  }

  static Future<List<News>> getLocalNewsFromNetwork() async {
    List<News> articles = [];
    try {
      final response = await http.get(Uri.parse(AppInfo.local_news_url));
      if (response.statusCode == 200) {
        articles = Utility.parseArticlesXml(response.body);
      }
    } catch (error) {
      print('=== API::LocalNewsFromNetwork::Error ${error.toString()}');
    }
    return articles;
  }

  ///this method will return news from google rss feed , searched by user from search screen
  static Future<List<News>> getSearchedNews(String q) async {
    List<News> articles = [];
    try {
      final response =
          await http.get(Uri.parse(AppInfo.local_news_url + "?q=$q"));
      if (response.statusCode == 200) {
        articles = Utility.parseArticlesXml(response.body);
      }
    } catch (error) {
      print('=== API::LocalNewsFromNetwork::Error ${error.toString()}');
    }
    return articles;
  }
}
