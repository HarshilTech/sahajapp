import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sahajapp/pages/rulesdetailspage.dart';

class rulesandregulationpage extends StatefulWidget {
  const rulesandregulationpage({super.key});

  @override
  State<rulesandregulationpage> createState() => _rulesandregulationpageState();
}

class _rulesandregulationpageState extends State<rulesandregulationpage> {

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
            "Rules And Regulations",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 5, left: 5, right: 5),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("rules")
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
                                                      rulesdetailspage(
                                                          documentSnapshot?[
                                                              "title"],
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
