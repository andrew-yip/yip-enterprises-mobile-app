import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {

  // to retrieve the user id and information
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // getter for user id
  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  // to reference all the products that there are
  final CollectionReference productsRef = FirebaseFirestore.instance.collection("StoreProducts"); // reference to store products

  // to reference the users and their specific data
  final CollectionReference userRef = FirebaseFirestore.instance.collection("Users"); // reference to users

}
