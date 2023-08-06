import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sahajapp/models/user_model.dart';

class currentuserdetailspage extends StatefulWidget {
  const currentuserdetailspage({super.key});

  @override
  State<currentuserdetailspage> createState() => _currentuserdetailspageState();
}

class _currentuserdetailspageState extends State<currentuserdetailspage> {
  final user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  var auth = FirebaseAuth.instance;
  var isLogin = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "My Profile Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5.0,
                offset: Offset(0, 3.0),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
// ------------------------- profile image -------------------------

              // CircleAvatar(
              //   radius: 80,
              //   backgroundImage: NetworkImage(loggedInUser.img ?? ""),
              // ),

              ClipOval(
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      // CircularProgressIndicator(),
                      SpinKitCircle(),
                  imageUrl: loggedInUser.img ?? "",
                  width: 140,
                  height: 140,
                ),
              ),

              SizedBox(height: 15),

// ------------------------- title fullname -------------------------

              FittedBox(
                child: Text(
                  loggedInUser.fullname ?? "",
                  style: TextStyle(fontSize: 22),
                ),
              ),

              SizedBox(
                height: 25,
              ),

              Divider(
                thickness: 2,
              ),

              SizedBox(
                height: 10,
              ),

// ------------------------- fullname -------------------------

              Container(
                height: 50,
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      // "Name:- ${loggedInUser.fullname}",
                      "${loggedInUser.fullname}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),

// ------------------------- email -------------------------

              Container(
                height: 50,
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      // "Gmail:- ${loggedInUser.email}",
                      "${loggedInUser.email}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),

// ------------------------- contact number -------------------------

              Container(
                height: 50,
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      // "Contact number:- ${loggedInUser.contactnumber}",
                      "${loggedInUser.contactnumber}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),

// ------------------------- contact number two -------------------------

              Container(
                height: 50,
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      // "Second contact number:- ${loggedInUser.contactnumbertwo}",
                      "${loggedInUser.contactnumbertwo}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),

// ------------------------- village -------------------------

              Container(
                height: 50,
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_filled,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Village:- ${loggedInUser.village}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 15,
              ),

// ------------------------- house number -------------------------

              Container(
                height: 50,
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Icon(
                      Icons.home,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "House number:- ${loggedInUser.housenumber}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
