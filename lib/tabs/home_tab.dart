import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/screens/product_details.dart';
import 'package:ecommerce_project/services/firebase_services.dart';
import 'package:ecommerce_project/widgets/custom_action_bar.dart';
import 'package:ecommerce_project/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// first tab that we have (explore page of products)

class HomePageTab extends StatefulWidget {

  // to reference firebase database info
  @override
  _HomePageTabState createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("StoreProducts");

  final _auth = FirebaseAuth.instance;

  User user = FirebaseAuth.instance.currentUser;

  String _userEmail;

  void getUserInfo() {
    user = _auth.currentUser;
    _userEmail = user.email;
    print(_userEmail);
  }

  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    getUserInfo(); // as soon as built, stores the user info
    return Container(
        child: Stack(children: [
      FutureBuilder<QuerySnapshot>(
        future: _firebaseServices.productsRef.orderBy("search_string").startAt([_searchString])
            .endAt(["$_searchString\uf8ff"])
            .get(), // querying data from firebase, // querying data from firebase
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          // Collection Data ready to display
          if (snapshot.connectionState == ConnectionState.done) {
            // Display the data inside a list view
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.all(12.0)),
                CustomInput(
                  hasMicrophone: true,
                  hintText: "Search Yip Enterprises",
                  onSubmitted: (value) {
                    setState(() {
                      _searchString = value.toLowerCase();
                    });
                  },
                ),
                Center(
                  child: Column(
                    children: [
                      Text("WELCOME, ", style: Constants.boldHeading,),
                      Text("$_userEmail", style: Constants.boldHeading,),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(2.0)),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 0.0,
                      bottom: 0.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ProductPage(productId: document.id),
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              height: 350.0,
                              margin: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 24.0,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 350.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.network(
                                        "${document.data()['images'][0]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            document.data()['name'] ?? "Product Name",
                                            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.red),

                                          ),
                                          Text(
                                              "\$${document.data()['price']}" ?? "Price",
                                              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.red)
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }

          // Loading state (if its not connected then the screen shows a progress indicator)
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        },
      ),
    ]));
  }
}
