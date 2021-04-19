
import 'package:ecommerce_project/screens/about_me.dart';
import 'package:ecommerce_project/screens/cart_page.dart';
import 'package:ecommerce_project/screens/saved_page.dart';
import 'package:ecommerce_project/widgets/custom_action_bar.dart';
import 'package:ecommerce_project/widgets/custom_btn.dart';
import 'package:ecommerce_project/widgets/logout_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

// your profile tab (the right most tab)

class ProfilePageTab extends StatelessWidget {

  final _auth = FirebaseAuth.instance;
  dynamic user;
  String _userEmail;

  // to store the users information

  void getUserInfo() {
    user = _auth.currentUser;
    _userEmail = user.email;
    print(_userEmail);
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo(); // to set the email and retrieve from data base
    return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomActionBar(
                    title: "Hello, \n$_userEmail",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 200.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(150.0),
                        child: Image(
                          image: AssetImage(
                              "assets/images/user.png"
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column( // specifically for navigation
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.orange,
                              gradient: new LinearGradient(
                                  colors: [Colors.red,Colors.yellow]
                              )
                          ),
                          child: buildAccountOptionRow(
                            context,
                            "Your Orders",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.orange,
                              gradient: new LinearGradient(
                                  colors: [Colors.red,Colors.yellow]
                              )
                          ),
                          child: buildAccountOptionRow(
                            context,
                            "Saved items",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.orange,
                              gradient: new LinearGradient(
                                  colors: [Colors.red,Colors.yellow]
                              )
                          ),
                          child: buildAccountOptionRow(
                            context,
                            "About",
                          ),
                        ),
                      ),
                    ],
                  ),
                  LogoutBtn(
                    imagePath: "assets/images/logout_tap.png",
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        "Contact Yip for help. ",
                        style: Constants.regularDarkText,
                      ),
                    ),
                  ),
                ],
              ),
          ),
        ),
    );
  }

  // logs out of the firebase account that is currently logged in
  void logOut () {
    FirebaseAuth.instance.signOut();
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Your Orders"){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CartPage(),
          ));
        }
        if (title == "Saved items"){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SavedPage(
            ),
          ));
        }
        if (title == "About"){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AboutMe(),
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {
                if (title == "Your Orders"){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ));
                }
                if (title == "Saved items"){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SavedPage(
                    ),
                  ));
                }
                if (title == "About"){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AboutMe(),
                  ));
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
