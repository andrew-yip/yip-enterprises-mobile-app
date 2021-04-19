import 'package:ecommerce_project/screens/initial_page.dart';
import 'package:flutter/material.dart';

// runs automatically once application is launched
void main() {
  runApp(MyApp()); //automatically run
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Courier New', // font for the whole app
        accentColor: Colors.lightBlue,
      ),
      home: InitialPage(), // renders landing page as soon as app is launched
    );
  }
}

