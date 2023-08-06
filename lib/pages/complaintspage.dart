import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahajapp/pages/addcomplaints.dart';
import 'package:sahajapp/pages/fullcomplaintview.dart';

class complaintspage extends StatefulWidget {
  complaintspage({Key? key}) : super(key: key);

  @override
  State<complaintspage> createState() => _complaintspageState();
}

class _complaintspageState extends State<complaintspage> {
  deletecomplaint(title) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("complaints").doc(title);

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addcomplaints()),
            );
          },
        ),
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            "All Complaints",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("complaints")
                .orderBy("time", descending: true)
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
                                            "${documentSnapshot?["title"]}\n${documentSnapshot?["date"]}"),
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
                                                      fullcomplaintsview(
                                                          documentSnapshot?[
                                                              "title"],
                                                          documentSnapshot?[
                                                              "description"],
                                                          documentSnapshot?[
                                                              "date"])),
                                            );
                                          },
                                        )
                                      ],
                                    ));
                                // );
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
