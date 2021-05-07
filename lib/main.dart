import 'package:flutter/material.dart';
import 'package:topix/primaries/Navigation.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/searchScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
        fontFamily: "BreeSerif",
        brightness: Brightness.light,
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
      ),
      routes: {'/search': (context) => SearchBar()},
      home: Navigation(),
    );
  }
}
