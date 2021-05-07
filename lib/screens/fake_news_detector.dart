import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:topix/services/fakeNewsDetectorService.dart';

class FNDetector extends StatefulWidget {
  @override
  _FNDetectorState createState() => _FNDetectorState();
}

class _FNDetectorState extends State<FNDetector> {
  ///query string entered by user
  String query = "";
  String result = "Result";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData(primaryColor: Colors.blue),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (i) {
                setState(() {
                  query = i;
                });
              },
              maxLines: 5,
              decoration: InputDecoration(hintText: "Enter your news"),
            ),
          ),
        ),
        ElevatedButton(
            onPressed: query == ""
                ? null
                : () async {
                    //response from API
                    setState(() {
                      result = "Analyzing... please wait";
                    });
                    Response res = await DetectFakeNews.analyze(query);
                    setState(() {
                      result = res.body;
                    });
                    print(res.body);
                  },
            child: Text("Analyze")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(result),
        )
      ],
    );
  }
}
