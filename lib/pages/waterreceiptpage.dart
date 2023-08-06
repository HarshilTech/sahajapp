import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:sahajapp/models/pdfapi.dart';
import 'package:sahajapp/models/waterrecieptapi.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class waterreceiptpage extends StatefulWidget {
  // favouritepage(String s, {Key? key}) : super(key: key);

  @override
  State<waterreceiptpage> createState() => _waterreceiptpageState();
}

class _waterreceiptpageState extends State<waterreceiptpage> {
  Dio dio = Dio();
  double progress = 0.0;

  var fileName = '/pspdfkit-flutter-quickstart-guide.pdf';

// URL of the PDF file you'll download.
  var imageUrl = 'https://pspdfkit.com/downloads';

  Future<void> removefavourite(id) async {
    FirebaseFirestore.instance
        .collection("wastewaterreceipt")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("receipt")
        .doc("title")
        .delete();
  }

  showDilogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Color.fromARGB(255, 81, 3, 141)),
          child: AlertDialog(
            title: Text("Nothing in favourites",
                style: TextStyle(color: Colors.white)),
            content: Icon(
              Icons.heart_broken,
              color: Colors.white,
              size: 60,
            ),
            // content: Image.asset("assets/images/sademoji.png", width: 80, height: 80,),
            actions: [
              Center(
                child: MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 110, vertical: 10),
                  color: Colors.white,
                  child: Text(
                    "Retry",
                    style: TextStyle(color: Color.fromARGB(255, 81, 3, 141)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "My Water Receipts",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5, left: 5, right: 5),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("wastewaterreceipt")
              // .doc(FirebaseAuth.instance.currentUser!.email)
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("receipt")
              // .where("url")
              .where("fullname")
              .snapshots(),
          builder: (context, snapshot) {
            return Center(
                child: !snapshot.hasData
                    ? CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, i) {
                              var fullname = snapshot.data!.docs[i]['fullname'];
                              var date = snapshot.data!.docs[i]['date'];
                              var fromdate = snapshot.data!.docs[i]['fromdate'];
                              var todate = snapshot.data!.docs[i]['todate'];
                              var rupee = snapshot.data!.docs[i]['rupee'];
                              var signature =
                                  snapshot.data!.docs[i]['signature'];
                              var housenumber =
                                  snapshot.data!.docs[i]['housenumber'];
                              return Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5.0,
                                        offset: Offset(0, 3.0),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      final pdfFile = await WaterreceiptApi
                                          .generateCentredText(
                                              fullname,
                                              date,
                                              fromdate,
                                              todate,
                                              rupee,
                                              signature,
                                              housenumber);
                                      WaterreceiptApi.openFile(pdfFile);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromARGB(
                                                255, 8, 113, 199),
                                            width: 3),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "|| ગણેશાય નમઃ ||",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 8, 113, 199)),
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 8, 113, 199),
                                                      width: 2)),
                                              child: FittedBox(
                                                child: Text(
                                                  "સહજ હોમ્સ ૩",
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 8, 113, 199)),
                                                ),
                                              )),
                                          FittedBox(
                                            child: Text(
                                              "રાધનપુર રોડ, મહેસાણા-૨",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 8, 113, 199)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      "નામ : ${fullname} ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Color.fromARGB(
                                                              255,
                                                              8,
                                                              113,
                                                              199)),
                                                    ),
                                                  ),
                                                  Text(
                                                    "ઘર નંબર : ${housenumber} ",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 8, 113, 199)),
                                                  ),
                                                ]),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              "આપે તારીખ:- ${date} ના રોજ પાણી નો બગાડ કરેલ છે.\nતો એના દંડ રૂપે આપને રૂપિયા:- ${rupee} નો દંડ આપવામાં આવે છે.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 8, 113, 199)),
                                            ),
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FittedBox(
                                                  child: Text("તારીખ:- ${date}",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 8, 113, 199),
                                                          fontSize: 15)),
                                                ),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: FittedBox(
                                                      child: Text(
                                                        "જમા કરનારની સહી:-\n${signature}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    8,
                                                                    113,
                                                                    199)),
                                                      ),
                                                    ))
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio:
                                        (width / 2.5) / (height / 6.5))),
                      ));
          },
        ),
      ),
    );
  }
}
