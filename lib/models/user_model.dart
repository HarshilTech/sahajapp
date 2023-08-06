class UserModel {
  String? uid;
  String? fullname;
  String? email;
  String? contactnumber;
  String? contactnumbertwo;
  String? housenumber;
  String? img;
  String? village;

  UserModel(
      {this.uid,
      this.fullname,
      this.email,
      this.contactnumber,
      this.contactnumbertwo,
      this.housenumber,
      this.img,
      this.village});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        fullname: map['fullname'],
        email: map['email'],
        contactnumber: map['contactnumber'],
        contactnumbertwo: map['contactnumbertwo'],
        housenumber: map['housenumber'],
        img: map['img'],
        village: map['village']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullname': fullname,
      'email': email,
      'contactnumber': contactnumber,
      'contactnumbertwo': contactnumbertwo,
      'housenumber': housenumber,
      'img': img,
      'village': village,
    };
  }
}

class ComplaintsModel {
  String? docid;
  String? title;
  String? description;

  ComplaintsModel({this.title, this.description, this.docid});
  factory ComplaintsModel.fromMap(map) {
    return ComplaintsModel(
      docid: map['docid'],
      title: map['title'],
      description: map['description'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'docid': docid,
      'title': title,
      'description': description,
    };
  }
}
