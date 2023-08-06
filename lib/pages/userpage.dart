import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahajapp/models/user_model.dart';
import 'package:sahajapp/pages/complaintspage.dart';
import 'package:sahajapp/pages/currentuserdetails.dart';
import 'package:sahajapp/pages/fullprofileview.dart';
import 'package:sahajapp/pages/loginpage.dart';
import 'package:sahajapp/pages/rulesandregulationpage.dart';
import 'package:sahajapp/pages/totalmember.dart';
import 'package:sahajapp/pages/upcomingevents.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sahajapp/pages/waterreceiptpage.dart';
import 'maintenencepage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class userpage extends StatefulWidget {
  userpage({Key? key}) : super(key: key);

  @override
  State<userpage> createState() => _userpageState();
}

class _userpageState extends State<userpage> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int complaints = 1;

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

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    Stream<QuerySnapshot<Map<String, dynamic>>> notificationStream =
        FirebaseFirestore.instance
            .collection("usrs-maintenence")
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection("receipt")
            .snapshots();

    notificationStream.listen((event) {
      if (event.docs.isEmpty) {
        return;
      }

      showNotifications(event.docs.first);
    });
  }

  void showNotifications(QueryDocumentSnapshot<Map<String, dynamic>> event) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('001', 'Local Notification',
            channelDescription: 'To send local notification');

    const NotificationDetails details =
        NotificationDetails(android: androidNotificationDetails);

    flutterLocalNotificationsPlugin.show(
        01, 'Maintenence', 'New Maintenence Receipt', details);
  }

  showDilogBox() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Colors.redAccent),
          child: AlertDialog(
            title:
                Text("Are you sure ?", style: TextStyle(color: Colors.white)),
            content: Text("Do you want to logout from this app",
                style: TextStyle(color: Colors.white)),
            actions: [
              MaterialButton(
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                color: Colors.white,
                child: Text(
                  "Cancle",
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                color: Colors.white,
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => loginpage(),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
// ----------------------------------- profile details ----------------------------------

              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => currentuserdetailspage()),
                  );
                },
                child: ListTile(
                  contentPadding: EdgeInsets.only(right: 0, left: 0),
                  leading: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                fullprofileview(loggedInUser.img ?? "")),
                      );
                    },
                    // child: CircleAvatar(
                    //   backgroundColor: Colors.orange,
                    //   radius: 40,
                    //   backgroundImage: NetworkImage(loggedInUser.img ?? ""),
                    // )
                    child: ClipOval(
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            //     CircularProgressIndicator(
                            //   color: Colors.orange,
                            // ),
                            //     SpinKitCircle(
                            //   color: Colors.orange,
                            //   size: 50.0,
                            // ),
                            // SpinKitFadingCube(color: Colors.orange),
                            // SpinKitCubeGrid(size: 51.0, color: Colors.orange),
                            // SpinKitRotatingCircle(color: Colors.orange),
                            SpinKitFadingCircle(color: Colors.orange),
                        imageUrl: loggedInUser.img ?? "",
                        fit: BoxFit.cover,
                        height: 55,
                        width: 55,
                      ),
                    ),
                  ),
                  title: Text(
                    "Hello",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    loggedInUser.fullname ?? "",
                    style: TextStyle(fontSize: 15),
                  ),
                  trailing: MaterialButton(
                      color: Colors.redAccent,
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        showDilogBox();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ),

              SizedBox(
                height: 5.0,
              ),
              Divider(
                thickness: 2,
              ),

              Expanded(
                  child: GridView.count(
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      crossAxisCount: 2,
                      children: [
// ----------------------------- members -------------------------------

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => totalmember()),
                        );
                      },
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/members.png",
                                        height: 120,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Society Members"),
                                      Text(snapshot.data!.size.toString()),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),

// ----------------------------- maintenance ----------------------------

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => maintenencepage()),
                        );
                      },
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("usrs-maintenence")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("receipt")
                            .where("url")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/reciept.png",
                                        height: 120,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("My Maintenance"),
                                      Text(snapshot.data!.size.toString()),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => complaintspage()),
                        );
                      },
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("complaints")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/complain.png",
                                        height: 120,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Complaints"),
                                      Text(snapshot.data!.size.toString()),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),

// ----------------------------- events ----------------------------

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => upcomingevents()),
                        );
                      },
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("festivals")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/event.png",
                                        height: 120,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Upcoming Events"),
                                      Text(snapshot.data!.size.toString()),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),

// ----------------------------- rules and regulation ----------------------------

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => rulesandregulationpage()),
                        );
                      },
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("rules")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/guidelines.png",
                                        height: 120,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Rules and Regulations"),
                                      Text(snapshot.data!.size.toString()),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),

                    // ----------------------------- waste water receipt ----------------------------

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => waterreceiptpage()),
                        );

                        // NotificationApi.showNotification(
                        //   title: 'test',
                        //   body: 'test notification',
                        //   payload: 'test.abs',
                        // );

                        // showNotification();
                      },
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("wastewaterreceipt")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("receipt")
                            .where("fullname")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/earth.png",
                                        height: 120,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Waste Water Receipts"),
                                      Text(snapshot.data!.size.toString()),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),
                  ])),

              Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      Text(
                        "Devloped by Harshil Tech ❤️",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
