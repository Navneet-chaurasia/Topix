import 'package:flutter/material.dart';
import 'package:topix/primaries/Navigation.dart';

void main() {
  runApp(Topix());
}

class Topix extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Topix',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Navigation(),
    );
  }
}
