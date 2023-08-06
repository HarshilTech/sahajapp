import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahajapp/pages/userpage.dart';

class Registerpage extends StatefulWidget {
  Registerpage({Key? key}) : super(key: key);

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final formKey = GlobalKey<FormState>();

  var fullname = "";
  var email = "";
  var contactnumber = "";
  var contactnumbertwo = "";
  var housenumber = "";

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final contactnumberController = TextEditingController();
  final contactnumbertwoController = TextEditingController();
  final housenumberController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    contactnumberController.dispose();
    contactnumbertwoController.dispose();
    housenumberController.dispose();
    super.dispose();
  }

  Future<void> adduser() async {
    return users
        .add({
          'fullname': fullname,
          'email': email,
          'contactnumber': contactnumber,
          'contactnumbertwo': contactnumbertwo,
          'housenumber': housenumber
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  cleartext() {
    fullnameController.clear();
    emailController.clear();
    contactnumberController.clear();
    contactnumbertwoController.clear();
    housenumberController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
        ),
        title: Text(
          "Register New User",
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 20,
                // ),
                Stack(
                  children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("assets/images/imagelogo.jpg"),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black.withOpacity(.5)),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  )
                ]),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),

// ----------------------------------------- full name field ----------------------------------------

                TextFormField(
                  controller: fullnameController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Enter full name',
                    prefixIcon: Icon(
                      Icons.person,
                      size: 30.0,
                      color: Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 20,
                ),

// ----------------------------------------- email address ----------------------------------------

                TextFormField(
                  controller: emailController,
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
                      size: 30.0,
                      color: Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    } else if (!value.contains('@')) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 20,
                ),

// ----------------------------------------- contact number ----------------------------------------

                TextFormField(
                  controller: contactnumberController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Enter contact number',
                    prefixIcon: Icon(
                      Icons.phone_android,
                      size: 30.0,
                      color: Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(patttern);

                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    } else if (!regExp.hasMatch(value)) {
                      return "please enter valid contact number";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 20,
                ),

// ----------------------------------------- second contact number ----------------------------------------

                TextFormField(
                  controller: contactnumbertwoController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Enter second contact number',
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 30.0,
                      color: Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(patttern);

                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    } else if (!regExp.hasMatch(value)) {
                      return "please enter valid contact number";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 20,
                ),

// ----------------------------------------- house number ----------------------------------------

                TextFormField(
                  controller: housenumberController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Enter house number',
                    prefixIcon: Icon(
                      Icons.home,
                      size: 30.0,
                      color: Colors.orange,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.orange),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    RegExp regExp = new RegExp(patttern);

                    if (value == null || value.isEmpty) {
                      return 'Please enter house number';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 35,
                ),

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
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              fullname = fullnameController.text;
                              email = emailController.text;
                              contactnumber = contactnumberController.text;
                              contactnumbertwo =
                                  contactnumbertwoController.text;
                              housenumber = housenumberController.text;

                              adduser();
                              cleartext();

                              const snackBar = SnackBar(
                                backgroundColor: Colors.orange,
                                content: Text('Registered successfully....'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });

                            Navigator.of(context).push(
                                MaterialPageRoute<Null>(builder: (context) {
                              return userpage();
                            }));
                          }
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
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        color: Colors.orange,
                        minWidth: 170,
                        height: 50,
                        onPressed: () {
                          cleartext();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Reset",
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
    );
  }
}
