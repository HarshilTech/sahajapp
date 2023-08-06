import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sahajapp/pages/memberdetailspage.dart';
import 'package:url_launcher/url_launcher.dart';

class totalmember extends StatefulWidget {
  totalmember({Key? key}) : super(key: key);

  @override
  State<totalmember> createState() => _totalmemberState();
}

class _totalmemberState extends State<totalmember> {
  // deleteuser(uid) {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection("users").doc(uid);

  //   documentReference
  //       .delete()
  //       .whenComplete(() => print("deleted successfully"));
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "Society Members",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .orderBy('housenumber')
                .snapshots(),
            builder: (context, snapshot) {
              return Center(
                  child: !snapshot.hasData
                      ? CircularProgressIndicator(
                          color: Colors.orange,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Object?>?
                                    documentSnapshot =
                                    snapshot.data?.docs[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              memberdetailspage(
                                                  documentSnapshot?["uid"])),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 5.0,
                                          offset: Offset(0, 3.0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // CircleAvatar(
                                        //   radius: 40,
                                        //   backgroundImage: NetworkImage(
                                        //       documentSnapshot?["img"]),
                                        // ),
                                        ClipOval(
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                //     CircularProgressIndicator(
                                                //   color: Colors.orange,
                                                // ),
                                                SpinKitCircle(
                                              color: Colors.orange,
                                              size: 50.0,
                                            ),
                                            imageUrl: documentSnapshot?["img"],
                                            fit: BoxFit.cover,
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        FittedBox(
                                          child: Text(
                                            documentSnapshot?["fullname"],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          documentSnapshot?["housenumber"],
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        MaterialButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          minWidth: width,
                                          color: Colors.orange,
                                          child: Text(
                                            "Call",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            launch(
                                                'tel:+91 ${documentSnapshot?["contactnumber"]}');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio:
                                          (width / 2.5) / (height / 3.5))),
                        ));
            },
          ),
        ),
      ),
    );
  }
}
