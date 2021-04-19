import 'package:ecommerce_project/screens/landing_page.dart';
import 'package:ecommerce_project/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

// widget for the first page that gets rendered as soon as application is launched by main.dart

class _InitialPageState extends State<InitialPage> {

  // builds the widget onto the screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                "YIP ENTERPRISES",
                style: Constants.boldHeading,
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width*.7,
                child: Column(
                  children: [
                    Text("We help connect people get the best products possible. ",
                    style: TextStyle(color: Colors.orange, fontSize: 18.0, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
            CustomBtn(
              text: "Continue",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
