import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_project/services/firebase_services.dart';
import 'package:ecommerce_project/widgets/custom_action_bar.dart';
import 'package:ecommerce_project/widgets/product_images.dart';
import 'package:ecommerce_project/widgets/product_quantity.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// each individual product page

class ProductPage extends StatefulWidget {
  final String productId;

  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  //final CollectionReference _productsRef =
    //  FirebaseFirestore.instance.collection("StoreProducts"); // reference to store products
  //final CollectionReference _userRef = FirebaseFirestore.instance.collection("Users"); // reference to users

  // Get user ID (the current user)
  //User _user = FirebaseAuth.instance.currentUser;

  // method for when you click the button to add to cart

  List allImages = [];
  List allId = [];
  List<Widget> totalStars = [];


  Map namesMap = {};// key is id/name value is link to image
  Map idMap = {};
  Map priceMap = {};

  // product quantity
  int _selectedProductQuantity = 0;

  //https://stackoverflow.com/questions/62356353/get-firestore-collections-based-on-values-in-array-list-in-flutter
  getAllImages() {

    //allImages = [];
    //allId = [];
    //totalStars = [];
    //map = {};

    FirebaseFirestore.instance.collection("StoreProducts").get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        List value = element.data()['images'];
        String id = element.id;
        print("hi this is my id: " + "$id");
        allId.add(id.toString());
        print(value);
        allImages.add(value[0]);

        //allImages = value;
        //FirebaseFirestore.instance.collection("items").doc(value[0]).get().then((value) {
        // print(value.data());
        // });

        // add to hashmap somehow
        namesMap.putIfAbsent(value[0], () => element.data()['name']);
        idMap.putIfAbsent(value[0], () => element.id);
        priceMap.putIfAbsent(value[0], () => element.data()['price']);

      });
    });
  }

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
      content: Text("Item successfully added to cart."),
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

  showAlertDialog2(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Saved selected item."),
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

  // this will go to the current user that you are at
  // go to the document affiliated with your user id
  // goes to cart collection and stores quantity (default is 1)
  Future _addToCart() {
    return _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection("Cart").doc(widget.productId).set(
        {"quantity": _selectedProductQuantity});
  } // creates new in cloud firestore with user id starts collection called cart and sets document with quantity 1

  Future _saveItem () {
  return _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection("Saved").doc(widget.productId).set({"quantity": _selectedProductQuantity});
  }

  @override
  Widget build(BuildContext context) {
    getAllImages();
    print(namesMap);
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: _firebaseServices.productsRef.doc(widget.productId).get(), // gets the data from firebase with widget id
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // when connected to the database
                if (snapshot.connectionState == ConnectionState.done) {
                  // Firebase Document Data map
                  Map<String, dynamic> documentData = snapshot.data.data();

                  // List of images (taken from database)
                  List imageList = documentData['images'];
                  List productQuantity = documentData['quantity']; // dynamic list
                  _selectedProductQuantity = 1; // default is the first one

                  if ("${documentData['stars']}" == "5"){
                    totalStars = [];
                    for (int i = 0; i<5; i++){
                      print(i);
                      totalStars.add(
                        Icon(
                          IconData(
                              0xea22, fontFamily: 'MaterialIcons'
                          ),
                          color: Colors.yellow,
                        ),
                      );
                    }
                    print(totalStars.length);
                  }

                  if ("${documentData['stars']}" == "4"){
                    totalStars = [];
                    for (int i = 0; i<4; i++){
                      print(i);
                      totalStars.add(
                        Icon(
                          IconData(
                              0xea22, fontFamily: 'MaterialIcons'
                          ),
                          color: Colors.yellow,
                        ),
                      );
                    }
                    print(totalStars.length);
                  }

                  if ("${documentData['stars']}" == "3"){
                    totalStars = [];
                    for (int i = 0; i<3; i++){
                      print(i);
                      totalStars.add(
                        Icon(
                          IconData(
                              0xea22, fontFamily: 'MaterialIcons'
                          ),
                          color: Colors.yellow,
                        ),
                      );
                    }
                    print(totalStars.length);
                  }

                  if ("${documentData['stars']}" == "2"){
                    totalStars = [];
                    for (int i = 0; i<2; i++){
                      print(i);
                      totalStars.add(
                        Icon(
                          IconData(
                              0xea22, fontFamily: 'MaterialIcons'
                          ),
                          color: Colors.yellow,
                        ),
                      );
                    }
                    print(totalStars.length);
                  }

                  if ("${documentData['stars']}" == "1"){
                    totalStars = [];
                    for (int i = 0; i<1; i++){
                      print(i);
                      totalStars.add(
                        Icon(
                          IconData(
                              0xea22, fontFamily: 'MaterialIcons'
                          ),
                          color: Colors.yellow,
                        ),
                      );
                    }
                    print(totalStars.length);
                  }

                  return ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      ImageSwipe(imageList: imageList,),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          "${documentData['name']}",
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text("\$${documentData['price']}",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 4.0,
                        ),
                        child: Row(
                          children: totalStars,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text("In Stock. Low Quantity. ",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Text("${documentData['desc']}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24.0),
                        child: Text(
                          "5 LIMIT MAX PER ITEM ",
                          style: TextStyle(color: Colors.red, fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24.0),
                        child: Text(
                          "Select quantity: ",
                          style: Constants.regularDarkText,
                        ),
                      ),

                      ProductQuantity(
                        productQuantities: productQuantity,
                        onSelected: (quantity) {
                          _selectedProductQuantity = quantity;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                //await _addToCart();
                                //print("Product Added to cart!");
                                await _saveItem();
                                showAlertDialog2(context);
                              },
                              child: Container(
                                  height: 65.0,
                                  width: 175.0,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image(
                                    width: 13.0,
                                    height: 21.0,
                                    image: AssetImage(
                                        "assets/images/save_tap.png"
                                    ),
                                  )
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await _addToCart();
                                //print("Product Added to cart!");
                                showAlertDialog(context);
                              },
                              child: Container(
                                height: 65.0,
                                width: 175.0,
                                margin: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Add to Cart",
                                    style: Constants.boldHeading,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 24.0),
                        child: Center(
                          child: Text(
                            "Customer Reviews: ",
                            style: Constants.boldHeading,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 24.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${documentData['reviews']}",
                            style: Constants.regularDarkText,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Center(
                          child: Text(
                            "Related Items",
                            style: Constants.regularDarkText,
                          ),
                        ),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(height: 400.0),
                        items: allImages.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ProductPage(productId: idMap[i]),
                                  ));
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50.0),
                                        color: Colors.lightBlue,
                                    ),
                                    //child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(12.0)
                                            ),
                                            child: Image.network(i)),
                                      ),
                                      Text(
                                        namesMap[i],
                                        style: Constants.boldHeading,
                                      ),
                                      Text(
                                        "\$${priceMap[i]}",
                                        style: Constants.regularDarkText,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  );
                }
                // Loading state
                return Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              }),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}
