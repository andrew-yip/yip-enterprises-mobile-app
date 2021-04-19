import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/screens/product_details.dart';
import 'package:ecommerce_project/services/firebase_services.dart';
import 'package:ecommerce_project/widgets/custom_action_bar.dart';
import 'package:ecommerce_project/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// tab for the items that you save or bookmark

class SavedPage extends StatefulWidget {

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        child: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection("Saved").get(), // querying data from firebase
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
                  return ListView(
                    padding: EdgeInsets.only(
                        top: 108.0,
                        bottom: 12.0
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
                                                          color: Colors.orange,
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
                    ));
              },
            ),
            CustomActionBar(
              title: "Saved Page",
              hasTitle: true,
              hasBackArrow: true,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBtn(
                text: "Clear Saved",
                onPressed: () {
                  setState(() {
                    _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection("Saved").get().then((snapshot) {
                      for (DocumentSnapshot ds in snapshot.docs){
                        ds.reference.delete();
                      }
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




