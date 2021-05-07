import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:xml/xml.dart' as xml;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:topix/secrets/AppInfo.dart';
import 'package:xml/xml.dart';

///News
/// structure
class News {
  num id;
  final String title;
  final String description;
  final String url;
  final String publishedAt;
  final String author;
  final String source;
  final String content;
  final String imageUrl;
  final String category;
  bool bookmarked = false;

  News(
      {this.id,
      this.title,
      this.description,
      this.url,
      this.publishedAt,
      this.author,
      this.source,
      this.content,
      this.imageUrl,
      this.category,
      this.bookmarked});

  factory News.fromMap(Map<String, dynamic> data, {network = false}) {
    return News(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      url: data['url'],
      publishedAt: data['publishedAt'],
      author: data['author'],
      source: network ? data['source']['name'] : data['source'],
      content: data['content'],
      imageUrl: data['urlToImage'],
      category: data['category'] ?? '',
      bookmarked: (data['bookmarked'] ?? false) == 1,
    );
  }

  Map<String, dynamic> toMap({category}) {
    return {
      'title': title,
      'description': description,
      'url': url,
      'publishedAt': publishedAt,
      'author': author,
      'source': source,
      'content': content,
      'urlToImage': imageUrl,
      'category': category ?? this.category,
      'bookmarked': bookmarked,
    };
  }

  String get timeAgo {
    var formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
//    var formatter = DateFormat("EEE, d MMM yyyy HH:mm:ss zzz");

    DateTime parsedDate;

    try {
      parsedDate = formatter.parse(publishedAt);
    } catch (error) {
      try {
        parsedDate =
            DateFormat("EEE, d MMM yyyy HH:mm:ss zzz").parse(publishedAt);
      } catch (error) {
        print('${error.toString()}');
      }
    }
    if (parsedDate != null) {
      Duration duration = DateTime.now().difference(parsedDate);

      if (duration.inDays > 7 || duration.isNegative) {
        return DateFormat.MMMMd().format(parsedDate);
      } else if (duration.inDays >= 1 && duration.inDays <= 7) {
        return duration.inDays == 1
            ? "1 day ago"
            : "${duration.inDays} days ago";
      } else if (duration.inHours >= 1) {
        return duration.inHours == 1
            ? "1 hour ago"
            : "${duration.inHours} hours ago";
      } else {
        return duration.inMinutes == 1
            ? "1 minute ago"
            : "${duration.inMinutes} minutes ago";
      }
    } else {
      return publishedAt;
    }
  }

  bool isNew() {
    var formatter = DateFormat("EEE, d MMM yyyy HH:mm:ss zzz");

    DateTime parsedDate = formatter.parse(publishedAt);
    Duration duration = DateTime.now().difference(parsedDate);
    if (duration.inHours < 24) {
      return true;
    }
    return false;
  }

  bool get isValid => title != null && title.length > 3 && url != null;
}

List<String> categories = [
  'Refresh',
  'For You',
  'Technology',
  'Business',
  'Entertainment',
  'Health',
  'Science',
  'Sports',
  'General',
];

enum Menu { local, headlines, favorites, FNDetector }

//some utility functions
class Utility {
  static String formatUrl(String country, String category, int page) {
    var url = '${AppInfo.base_url}/top-headlines?page=$page';
    if (country != null && country.isNotEmpty) {
      url += '&country=$country';
    }
    if (category != null && category.isNotEmpty) {
      url += '&category=$category';
    }
    return url += '&apiKey=${AppInfo.api_key}';
  }

  ///share method to share the news link with other apps
  static shareNews(String image, String title) async {
    var request = await HttpClient().getUrl(Uri.parse(image));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('News Shared from Topix', 'topix.jpg', bytes, 'image/jpg',
        text: title);
  }

//this will parse the news into News modal
  static List<News> parseNews(String responseBody) {
    List<News> articles = [];
    final parsed = json.decode(responseBody);
    if (parsed['totalResults'] > 0) {
      articles = List<News>.from(parsed['articles']
          .map((article) => News.fromMap(article, network: true)));
    }
    return articles;
  }

  ///parse xml document
  static List<News> parseArticlesXml(String responseBody) {
    //var document = xml.parse(responseBody);
    var document = xml.XmlDocument.parse(responseBody);

    var channelElement = document.findAllElements("channel")?.first;
    // var source = findElementOrNull(channelElement, 'title')?.text;

    return channelElement.findAllElements('item').map((element) {
      var title = findElementOrNull(element, 'title')?.text;
      var description = findElementOrNull(element, "description")?.text;
      var source2 = element.findElements("source").first.getAttribute('url');
      var link = findElementOrNull(element, "link")?.text;
//    var category =
//        element.findElements("category").first.getAttribute('domain');
      var pubDate = findElementOrNull(element, "pubDate")?.text;
      var author = findElementOrNull(element, "author")?.text;
      var image =
          findElementOrNull(element, "enclosure")?.getAttribute("url") ?? null;

      return News(
          title: title,
          category: 'local',
          author: author,
          content: description,
          imageUrl: image,
          publishedAt: pubDate,
          url: link,
          source: source2?.replaceAll('https://www.', '') ?? '',
          description: description);
    }).toList();
  }

  static XmlElement findElementOrNull(XmlElement element, String name) {
    try {
      return element.findAllElements(name).first;
    } on StateError {
      return null;
    }
  }
}
