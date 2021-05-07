import 'package:http/http.dart' as http;

///this class contains some static methods
///essentials for detecting fake news
class DetectFakeNews {
  ///@params : query
  ///this functions return future resposne
  ///true or false
  ///whether news is genuine or not
  static Future<http.Response> analyze(String q) async {
    return http.post(
      Uri.https('dawg-fake-news-detector.p.rapidapi.com', 'predict'),
      headers: <String, String>{
        "content-type": "application/x-www-form-urlencoded",
        "x-rapidapi-key": "4b59b321b3mshebb7ee805dbbeb1p116dcdjsna564225410d6",
        "x-rapidapi-host": "dawg-fake-news-detector.p.rapidapi.com",
        "useQueryString": "true"
      },
      body: <String, String>{
        'text': q,
      },
    ).catchError((onError) {
      print(onError);
    });
  }
}
