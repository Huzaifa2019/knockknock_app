import 'package:flutter/material.dart';
import 'HomeScreen.dart';

//import 'package:http/http.dart' as http;
//   flutter pub run flutter_launcher_icons:main    (for image )
//String url = 'https://knock-knock-f1915.firebaseio.com/';

//   flutter build apk --split-per-abi   (for release apk version)

void main() async {
  runApp(new FirstApp());
}

class FirstApp extends StatefulWidget {
  @override
  _FirstAppState createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Knock Knock",
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}
