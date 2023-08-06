import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sahajapp/models/user_model.dart';

class memberdetailspage extends StatefulWidget {
  String uid;
  memberdetailspage(this.uid);

  @override
  State<memberdetailspage> createState() => _memberdetailspageState();
}

class _memberdetailspageState extends State<memberdetailspage> {
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Member Details",
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

                CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(loggedInUser.img ?? ""),
                    backgroundColor: Colors.orange),

                // ClipOval(
                //   child: CachedNetworkImage(
                //     placeholder: (context, url) => CircularProgressIndicator(
                //       color: Colors.orange,
                //     ),
                //     //     SpinKitCircle(
                //     //   color: Colors.orange,
                //     //   size: 50.0,
                //     // ),
                //     imageUrl: loggedInUser.img ?? "",
                //     fit: BoxFit.cover,
                //     height: 60,
                //     width: 60,
                //   ),
                // ),

                SizedBox(height: 15),

// ------------------------- title fullname -------------------------

                FittedBox(
                  child: Text(
                    loggedInUser.fullname ?? "",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                        color: Colors.white,
                        size: 30,
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
                        color: Colors.white,
                        size: 30,
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
                        color: Colors.white,
                        size: 30,
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
                        color: Colors.white,
                        size: 30,
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
                        Icons.house,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "House number ${loggedInUser.housenumber}",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
