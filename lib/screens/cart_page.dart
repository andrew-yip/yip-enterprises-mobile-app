import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/screens/product_details.dart';
import 'package:ecommerce_project/services/firebase_services.dart';
import 'package:ecommerce_project/widgets/custom_action_bar.dart';
import 'package:ecommerce_project/widgets/custom_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget{
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  FirebaseServices _firebaseServices = FirebaseServices();
  // total price
  double total = 0;
  double totalFormatted = 0;

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Checkout page hasn't been implemented yet."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    //total = 0;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection("Cart").get(), // querying data from firebase
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              //total = 0;

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view

                total = 0;
                return ListView(
                        padding: EdgeInsets.only(
                          top: 108.0,
                          bottom: 12.0
                        ),
                        children: snapshot.data.docs.map((document) { // document of the cart
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ProductPage(productId: document.id),
                                  ));
                                },
                                child: FutureBuilder(
                                  future: _firebaseServices.productsRef.doc(document.id).get(),
                                  builder: (context, productSnap) {

                                    if (productSnap.hasError){
                                      return Container(
                                        child: Center(
                                          child: Text(
                                            "${productSnap.error}"
                                          ),
                                        ),
                                      );
                                    }

                                    if (productSnap.connectionState == ConnectionState.done) {
                                      Map _productMap = productSnap.data.data();

                                      total += int.parse(_productMap['price']) * int.parse(document.data()['quantity'].toString());
                                      print('total atm');
                                      print(total);

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                          horizontal: 24.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 90,
                                              height: 90,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  "${_productMap['images'][0]}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: 16.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${_productMap['name']}",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 4.0,
                                                    ),
                                                    child: Text(
                                                      "\$${_productMap['price']}",
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Theme.of(context)
                                                              .accentColor,
                                                          fontWeight:
                                                          FontWeight.w600),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Quantity - ${document.data()['quantity']}",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                )
                              ),
                            ],
                          );
                        }).toList(),
                      );
              }
              // Loading state (if its not connected then the screen shows a progress indicator)
              return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  )
              );
            },
          ),
          CustomActionBar(
            hasBackArrow: true,
            title: "Cart",
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 75),
            child:
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                  "Total: \$$total",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomBtn(
                  text: "Checkout",
                  onPressed: () {
                    showAlertDialog(context);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomBtn(
                  text: "Clear Cart",
                  onPressed: () {
                    setState(() {
                      _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection("Cart").get().then((snapshot) {
                        for (DocumentSnapshot ds in snapshot.docs){
                          ds.reference.delete();
                        }
                      });
                      total = 0;
                    });
                  },
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

