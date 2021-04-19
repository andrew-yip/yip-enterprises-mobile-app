import 'package:ecommerce_project/widgets/custom_btn.dart';
import 'package:ecommerce_project/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// register screen

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // DEFAULT FORM LOADING STATE
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode; //so when you press enter it takes you to the next field

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView( // to have scrollable screen to take in one child and many sub childs
            child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: 24.0,
                        ),
                        child: Text("Yip Enterprises\nCreate a new account",
                            textAlign: TextAlign.center,
                            style: Constants.boldHeading),
                      ),
                      Padding(padding: EdgeInsets.all(30.0)),
                      Column(children: [
                        CustomInput(
                          hintText: "Email...",
                          onChanged:(value){
                            _registerEmail = value;
                          },
                          onSubmitted: (value) {
                            _passwordFocusNode.requestFocus();
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        CustomInput(
                          hintText: "Password...",
                          onChanged: (value) {
                            _registerPassword = value;
                          },
                          focusNode: _passwordFocusNode,
                          isPasswordField: true,
                          onSubmitted: (value) {
                            _submitForm();
                          },
                        ),
                        Padding(padding: EdgeInsets.all(20.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CustomBtn(text: "REGISTER NOW",
                                onPressed: () {
                                  _submitForm();
                                },
                                isLoading: _registerFormLoading,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CustomBtn(
                                text: "Back to Login",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                outlineBtn: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                      ),
                      Container(
                        height: 200.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image(
                            image: AssetImage(
                                "assets/images/jackiechan.jpg"
                            ),
                          ),
                        ),
                      ),
                    ])),
          )),
    );
  }

  // build an alert dialog to display some errors
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(child: Text(error)),
            actions: [FlatButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Close Dialog"))],
          );
        });
  }

  // Create a new user account (documentation)
  Future<String> _createUserWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword
        (email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
       return ('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      return (e.toString());
    }
  }

  // when clicking submit to register for an account
  void _submitForm () async {
    // SET THE FORM TO LOADING STATE
    setState(() {
      _registerFormLoading = true;
    });

    // RUN THE CREATE ACCOUNT METHOD
    String _createAccountFeedback = await _createUserWithEmailAndPassword(); // retrieves the string that is returned

    // if the string is not null, we got error while creating account
    if (_createAccountFeedback != null){
      _alertDialogBuilder(_createAccountFeedback); // send an alert that shows the error returned
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context); // otherwise we go to the next screen
    }
  }
}
