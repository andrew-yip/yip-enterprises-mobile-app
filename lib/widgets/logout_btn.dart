import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// custom log out btn

class LogoutBtn extends StatelessWidget {
  final String imagePath;

  LogoutBtn({this.imagePath}); // constructor

  // builds the widget onto the screen
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: logOut,
      child: Container(
        height: 45.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Stack(
          children: [
            Center(
                child: Image(
              image: AssetImage(
                imagePath,
              ),
            )),
          ],
        ),
      ),
    );
  }

  // function to sign out of firebase account
  logOut() {
    FirebaseAuth.instance.signOut();
  }
}
