import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/constants.dart';
import 'package:ecommerce_project/screens/cart_page.dart';
import 'package:ecommerce_project/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// action bar on the top of the screen

class CustomActionBar extends StatelessWidget {
  // DATA MEMBERS
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackground;
  CustomActionBar({this.title, this.hasBackArrow, this.hasTitle, this.hasBackground}); // CONSTRUCTOR

  // FIREBASE
  FirebaseServices _firebaseServices = FirebaseServices();
  //final CollectionReference _userRef = FirebaseFirestore.instance.collection("Users"); // reference to users
  //final User _user = FirebaseAuth.instance.currentUser; // current user that is signed in

  // builds the widget onto the screen

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;



    return Container(
      decoration: BoxDecoration(
        gradient: _hasBackground ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0,0),
          end: Alignment(0,1),
        ): null ,
      ),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // pop context goes back to previous page of context
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage(
                    "assets/images/back_arrow.png",
                  ),
                  color: Colors.white,
                  width: 16.0,
                  height: 18.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
            title ?? "Action Bar",
            style: Constants.boldHeading,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CartPage(),
              ));
            },
            child: Container(
              width: 42.0,
              height: 42.0,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(100.0),
              ),
              alignment: Alignment.center,
              child: StreamBuilder( // to get updates on the # of items per cart
                stream: _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection("Cart").snapshots(), // to get everything in real time
                builder: (context, snapshot) {
                  int _cartTotal = 0;

                  // when connected to firebase
                  if (snapshot.connectionState == ConnectionState.active){
                    // if active connection state we want list of all documents
                    List _documents = snapshot.data.docs; // all the documents in the cart associated with the user

                    // calculate the total amount of items
                    _cartTotal = 0;
                    for (int i =0; i<_documents.length; i++){
                      print(_documents[i]['quantity']);
                      _cartTotal += _documents[i]['quantity'];
                    }
                  }
                  return Text(
                      "$_cartTotal" ?? "0",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )
                  );
                }
              ),
            ),
          ),
        ]
      ),
    );
  }
}
