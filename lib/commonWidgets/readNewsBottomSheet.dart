import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:webview_flutter/webview_flutter.dart';

///this class contains static method to show bottom sheet
class ReadNews {
  static void showBotttomSheet(BuildContext context, String url) {
    showModalBottomSheet(
        elevation: 8.0,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return ReadNewsBottomSheet(url: url);
        });
  }
}

///Auth bottom sheet
///when user will press Signup button this Bottom sheet will appear from nowhere and will fuck the user
///

class ReadNewsBottomSheet extends StatefulWidget {
  final String url;
  ReadNewsBottomSheet({this.url});
  @override
  _ReadNewsBottomSheetState createState() => _ReadNewsBottomSheetState();
}

class _ReadNewsBottomSheetState extends State<ReadNewsBottomSheet> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: WebviewScaffold(
        hidden: true,
        initialChild: SpinKitDoubleBounce(
          color: Colors.black,
        ),
        url: widget.url,
        appBar: new AppBar(
          title: new Text("Read News"),
          elevation: 0,
          centerTitle: true,
        ),
      ),
    );
  }
}
