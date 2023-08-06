import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sahajapp/models/user_model.dart';
import 'package:sahajapp/pages/loginpage.dart';
import 'package:sahajapp/pages/userpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class newuserpage extends StatefulWidget {
  newuserpage({Key? key}) : super(key: key);

  @override
  State<newuserpage> createState() => _newuserpageState();
}

class _newuserpageState extends State<newuserpage> {
  ImagePicker imagePicker = ImagePicker();

  //auth instance
  final _auth = FirebaseAuth.instance;

  //from key
  final formKey = GlobalKey<FormState>();

  //text field variabels
  var fullname = "";
  var email = "";
  var contactnumber = "";
  var contactnumbertwo = "";
  var housenumber = "";
  var password = "";
  var conformpassword = "";
  var village = "";
  var birthday = "";
  String imageUrl = '';

  // all textfield controllers
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final contactnumberController = TextEditingController();
  final contactnumbertwoController = TextEditingController();
  final housenumberController = TextEditingController();
  final passwordController = TextEditingController();
  final conformpasswordController = TextEditingController();
  final villageController = TextEditingController();
  TextEditingController birthdate = TextEditingController();

  // dispose controllers
  @override
  void dispose() {
    fullnameController.dispose();
    emailController.dispose();
    contactnumberController.dispose();
    contactnumbertwoController.dispose();
    housenumberController.dispose();
    villageController.dispose();
    birthdate.dispose();
    passwordController.dispose();
    conformpasswordController.dispose();
    super.dispose();
  }

  // new member authanticaton
  void signup(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        return Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  // store new member data to firestore
  postDetailsToFirestore() async {
    //firestore collection reference
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    //current user
    User? user = _auth.currentUser;

    //model for data send and recive
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullname = fullnameController.text;
    userModel.contactnumber = contactnumberController.text;
    userModel.contactnumbertwo = contactnumbertwoController.text;
    userModel.housenumber = housenumberController.text;
    // userModel.village = villageController.text;
    userModel.img = imageUrl;
    userModel.village = villageController.text;

    //firestore document reference
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    //show toast message
    Fluttertoast.showToast(
        msg: "Account created successful....", backgroundColor: Colors.orange);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => loginpage(),
      ),
    );
  }

  //clear textfield controller
  cleartext() {
    fullnameController.clear();
    emailController.clear();
    contactnumberController.clear();
    contactnumbertwoController.clear();
    housenumberController.clear();
    villageController.clear();
    birthdate.clear();
  }

  late File? _imgage = null;

  //pick image from gallery
  pickimage() async {
    //pick image
    // ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    setState(() {
      _imgage = File(file!.path);
    });

    if (file == null) return;

    //generate uniq filename
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //firebase storage main reference
    Reference referanceRoot = FirebaseStorage.instance.ref();

    //firebase storage child reference
    Reference referanceDirImages = referanceRoot.child("members");

    //firebase storage upload reference
    Reference referanceImageToUpload = referanceDirImages.child(uniqueFileName);

    //try to upload file
    try {
      int i = 1;
      // store the file
      await referanceImageToUpload.putFile(File(file.path));
      //  success: get the download URL
      imageUrl = await referanceImageToUpload.getDownloadURL();
    } catch (error) {
      // some error occurred
    }

    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please upload an image')));
      return;
    }
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
          "Register New Member",
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
                Stack(children: [
// -------------------------- profile image --------------------------

                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipOval(
                      child: (_imgage != null)
                          ? Image.file(_imgage!)
                          : Image.asset('assets/images/imagelogo.jpg'),
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
                        onPressed: () {
                          pickimage();
                        },
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

// ----------------------------------------- email ----------------------------------------

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

// ----------------------------------------- password ----------------------------------------

                TextFormField(
                  controller: passwordController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Enter password',
                    prefixIcon: Icon(
                      Icons.password,
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
                      return 'Please enter password';
                    } else if (value.length < 6) {
                      return "Please enter password at least 6 character";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 20,
                ),

// ----------------------------------------- conform password ----------------------------------------

                TextFormField(
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Enter conform password',
                    prefixIcon: Icon(
                      Icons.password,
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
                    if (value != passwordController.text) {
                      return "Password don't match";
                    } else if (value == null || value.isEmpty) {
                      return "Please enter conform password";
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
                    hintText: 'Second contact number(Optional)',
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
                      return null;
                    } else if (!regExp.hasMatch(value)) {
                      return "please enter valid contact number";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 20,
                ),

// ----------------------------------------- village ----------------------------------------

                TextFormField(
                  controller: villageController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Enter your village',
                    prefixIcon: Icon(
                      Icons.house_rounded,
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
                      return 'Please enter your village';
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
                    // String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                    // RegExp regExp = new RegExp(patttern);

                    // if (value == null || value.isEmpty) {
                    //   return 'Please enter house number';
                    // }
                    // return null;

                    if (value == null || value.isEmpty) {
                      return "Please enter house number";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 35,
                ),

// ------------------------------ register and reset buttons ---------------------------------

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
// // ----------------------------------- register button ------------------------------------

//                     Container(
//                       // padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: MaterialButton(
//                         color: Colors.orange,
//                         minWidth: 170,
//                         height: 50,
//                         onPressed: () {
//                           signup(emailController.text, passwordController.text);
//                         },
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50)),
//                         child: Text(
//                           "Register",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: 18),
//                         ),
//                       ),
//                     ),

// ----------------------------------- reset buttons ------------------------------------

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

// ----------------------------------- register button ------------------------------------

                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        color: Colors.orange,
                        minWidth: 170,
                        height: 50,
                        onPressed: () {
                          signup(emailController.text, passwordController.text);
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
