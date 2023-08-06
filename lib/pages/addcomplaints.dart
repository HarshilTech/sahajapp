import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class addcomplaints extends StatefulWidget {
  addcomplaints({Key? key}) : super(key: key);

  @override
  State<addcomplaints> createState() => _addcomplaintsState();
}

class _addcomplaintsState extends State<addcomplaints> {
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  var title = "";
  var description = "";

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  addComplaints() async {
    if (_formKey.currentState!.validate()) {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("complaints")
          .doc(titleController.text);

      // documentReference.set(complain).whenComplete(() {
      //   Fluttertoast.showToast(msg: "Complain Added Successfully");
      // });

      // Map<String, String> complain = {
      //   "title": titleController.text,
      //   "date": dateinput.text,
      //   "description": descriptionController.text,
      // };

      documentReference.set({
        "title": titleController.text,
        "date": dateinput.text,
        "description": descriptionController.text,
        "time": Timestamp.now()
      }).whenComplete(() {
        Fluttertoast.showToast(msg: "Complain Added Successfully");
      });

      Navigator.pop(context);
    }
  }

  cleartext() {
    titleController.clear();
    descriptionController.clear();
  }

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/complainone.png",
                      width: 200,
                      height: 200,
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),

// --------------------------------- title --------------------------------

                  TextFormField(
                    controller: titleController,
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(width: 0.8),
                      ),
                      hintText: 'Enter title',
                      prefixIcon: Icon(
                        Icons.title,
                        size: 30.0,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Title';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),

// --------------------------------- date --------------------------------

                  TextFormField(
                    controller: dateinput,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);

                        setState(() {
                          dateinput.text = formattedDate;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    cursorColor: Colors.orange,
                    decoration: InputDecoration(
                      hintText: "Enter event date",
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(width: 0.8)),
                      prefixIcon: Icon(
                        Icons.date_range,
                        size: 30,
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
                  ),

                  SizedBox(
                    height: 20,
                  ),

// --------------------------------- description --------------------------------

                  TextFormField(
                    maxLines: null,
                    controller: descriptionController,
                    cursorColor: Colors.orange,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(width: 0.8),
                      ),
                      hintText: 'Enter description',
                      prefixIcon: Icon(
                        Icons.description,
                        size: 30.0,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Description';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),

// --------------------------------- button --------------------------------

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: MaterialButton(
                          color: Colors.orange,
                          minWidth: 170,
                          height: 50,
                          onPressed: () {
                            addComplaints();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "Complaint",
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
      ),
    );
  }
}
