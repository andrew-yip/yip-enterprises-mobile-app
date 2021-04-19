import 'package:ecommerce_project/constants.dart';
import 'package:ecommerce_project/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "About Me: ",
              style: Constants.boldHeading,
            ),
            Text(
              "Visit andrewayip.com for more. ",
              style: Constants.regularDarkText,
            ),
            CustomBtn(
              text: "Go back",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
      ),
    );
  }
}
