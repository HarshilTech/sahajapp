import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahajapp/pages/eventdetails.dart';

class upcomingevents extends StatefulWidget {
  upcomingevents({Key? key}) : super(key: key);

  @override
  State<upcomingevents> createState() => _upcomingeventsState();
}

class _upcomingeventsState extends State<upcomingevents> {
  deletecomplaint(festival) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("festivals").doc(festival);

    documentReference
        .delete()
        .whenComplete(() => print("deleted successfully"));
  }

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
            "Upcoming Festival",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("festivals")
                .orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return Center(
                  child: !snapshot.hasData
                      ? CircularProgressIndicator()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Object?>?
                                    documentSnapshot =
                                    snapshot.data?.docs[index];

                                return Container(
                                    alignment: Alignment.centerLeft,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${documentSnapshot?["festival"]}\n${documentSnapshot?["date"]}"),
                                        MaterialButton(
                                          minWidth: 15,
                                          height: 30,
                                          color: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Text(
                                            "View",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      eventdetails(
                                                          documentSnapshot?[
                                                              "festival"],
                                                          documentSnapshot?[
                                                              "date"],
                                                          documentSnapshot?[
                                                              "description"])),
                                            );
                                          },
                                        )
                                      ],
                                    ));
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio:
                                          (width / 2.5) / (height / 20))),
                        ));
            },
          ),
        ),
      ),
    );
  }
}
