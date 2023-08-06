import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahajapp/pages/newuser.dart';
import 'package:sahajapp/pages/userpage.dart';

class loginpage extends StatefulWidget {
  loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _formKey = GlobalKey<FormState>();

  //textfield variables
  var email = "";
  var password = "";

  //textfield contoller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //member login
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => userpage(),
        ),
      );
      Fluttertoast.showToast(
          msg: "Login successful..", backgroundColor: Colors.orange);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          Fluttertoast.showToast(
              msg: "Your email address appears to be malformed.",
              backgroundColor: Colors.orange);
          break;
        case "wrong-password":
          Fluttertoast.showToast(
              msg: "Your password is wrong.", backgroundColor: Colors.orange);
          break;
        case "user-not-found":
          Fluttertoast.showToast(
              msg: "User with this email doesn't exist.",
              backgroundColor: Colors.orange);
          break;
        case "user-disabled":
          Fluttertoast.showToast(
              msg: "User with this email doesn't exist.",
              backgroundColor: Colors.orange);
          break;
        case "too-many-requests":
          Fluttertoast.showToast(
              msg: "Too many requests", backgroundColor: Colors.orange);
          break;
        case "operation-not-allowed":
          Fluttertoast.showToast(
              msg: "Signing in with Email and Password is not enabled.",
              backgroundColor: Colors.orange);
          break;
        default:
          Fluttertoast.showToast(
              msg: "An undefined Error happened.",
              backgroundColor: Colors.orange);
      }
    }
  }

  // Clean up the controller when the widget is disposed.
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Image.asset(
                          "assets/images/sahajappicon200.png",
                          width: 200,
                          height: 200,
                        )),

                    SizedBox(
                      height: 40,
                    ),

// --------------------------------- email --------------------------------

                    TextFormField(
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(width: 0.8),
                        ),
                        hintText: 'Enter email',
                        prefixIcon: Icon(
                          Icons.email,
                          // size: 30.0,
                          color: Colors.orange,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.orange),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.orange),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),

// --------------------------------- password --------------------------------

                    TextFormField(
                      cursorColor: Colors.orange,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(width: 0.8),
                        ),
                        hintText: 'Enter password',
                        prefixIcon: Icon(
                          Icons.password,
                          // size: 30.0,
                          color: Colors.orange,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.orange),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.0, color: Colors.orange),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 20,
                    ),

// --------------------------------- button --------------------------------

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 20),
                          child: MaterialButton(
                            color: Colors.orange,
                            minWidth: 170,
                            height: 50,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => newuserpage()),
                              );
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        Container(
                          child: MaterialButton(
                            color: Colors.orange,
                            minWidth: 170,
                            height: 50,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                  password = passwordController.text;
                                });
                                userLogin();
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
