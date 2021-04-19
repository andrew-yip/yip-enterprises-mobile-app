import 'package:ecommerce_project/screens/register_page.dart';
import 'package:ecommerce_project/widgets/custom_btn.dart';
import 'package:ecommerce_project/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// login screen

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Default Form Loading State
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

  // Focus Node for input fields
  FocusNode _passwordFocusNode;

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
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Text(
                    "Yip Enterprises\nLogin to your account",
                    textAlign: TextAlign.center,
                    style: Constants.boldHeading,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Email",
                      onChanged: (value) { // updates _loginEmail in real time
                        _loginEmail = value;
                      },
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password",
                      onChanged: (value) {
                        _loginPassword = value;
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
                          child: CustomBtn(
                            text: "Login",
                            onPressed: () {
                              _submitForm();
                            },
                            isLoading: _loginFormLoading,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16.0,
                          ),
                          child: CustomBtn(
                            text: "Create New Account",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()
                                ),
                              );
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // dialog message in case there is an error
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }

  // Create a new user account
  Future<String> _signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // when you submit the form
  void _submitForm() async {
    // Set the form to loading state
    setState(() {
      _loginFormLoading = true;
    });

    // Run the create account method
    String _loginFeedback = await _signInWithEmailAndPassword();

    // If the string is not null, we got error while create account.
    if(_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    }
  }
}