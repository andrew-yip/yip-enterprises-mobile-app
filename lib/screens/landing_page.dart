import 'package:ecommerce_project/screens/home_page.dart';
import 'package:ecommerce_project/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

// Used documentation for this

class LandingPage extends StatelessWidget{

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // builds the widget onto the screen

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( // updates in real time
        future: _initialization,
        builder: (context, snapshot){
          // Check for errors
          if (snapshot.hasError){
            return Scaffold(
                body: Center(
                  child: Text(" Error:  ${snapshot.error}"), // display the error on the screen
                )
            );
          }

          // connection initialized - firebase app is running
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done){
            // Streambuilder can check the login state live
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot){ // snapshot changed to stream snap shot and checking with stream builder
                // if stream snapshot has error
                if (streamSnapshot.hasError){
                  return Scaffold(
                      body: Center(
                        child: Text(" Error:  ${streamSnapshot.error}"),
                      )
                  );
                }

                // Once complete, show your application
                // connection state active - do the user login check inside if statement
                // once authentication is active, launch the app
                if (streamSnapshot.connectionState == ConnectionState.active){
                  // Get the user
                  User _user = streamSnapshot.data;

                  // if user isn't logged in
                  if (_user == null){
                    return LoginPage();
                  } else { // if user is logged in render/go to the homepage
                    return HomePage();
                  }
                }

                // Otherwise, show something whilst waiting for initialization to complete
                // while we are waiting to see if your authentication is valid
                // checking the authentication state - loading
                return Scaffold(
                    body: Center(
                        child: Text("Verifying Authentication...",
                            style: Constants.regularHeading)
                    )
                );
              }
            );
          }

          // Once complete, show your application
          // connecting to firebase - loading
          return Scaffold(
              body: Center(
                  child: Text("Initializing app...",
                  style: Constants.regularHeading)
              )
          );
        }
    );
  }
}
