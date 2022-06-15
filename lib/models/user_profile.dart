import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late String email;
  late String contactNum;
  late String address;
  late String fathername;
  late String mothername;
  late String companyName;
  late DateTime dob;
  late String id;
  late String companyAddress;
  late String userId;
  late String userDp;
  late String position;
  late String qualification;
  late String experience;
  late String aadharFront;
  late String aadharBack;

  // Constructor with name parameters
  UserModel(
      {required this.name,
      required this.email,
      required this.companyName,
      required this.contactNum,
      required this.address,
      required this.fathername,
      required this.companyAddress,
      required this.dob,
      required this.position,
      required this.userDp,
      required this.experience,
      required this.qualification,
      required this.aadharFront,
      required this.aadharBack});

  // Constructor from json
  // UserModel.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       email = json['email'],
  //       contactNum = json['contactNum'],
  //       address = json['address'],
  //       fathername = json['fathername'],
  //       mothername = json['mothername'],
  //       companyName = json['companyName'],
  //       dob = json['dob'],
  //       position = json['position'];

  // Constructor from firestore document
  UserModel.fromDocument(DocumentSnapshot doc) {
    name = doc['name'];
    email = doc['email'];
    contactNum = doc['phone'];
    address = doc['address'];
    companyName = doc['company_name'];
    fathername = doc['fathername'];
    dob = (doc['dob'] as Timestamp).toDate();
    position = doc['position'];
    id = doc.id;
    userId = doc['user'];
    companyAddress = doc['company_address'];
    userDp = doc['profile_image'];
    experience = doc['experience'];
    qualification= doc['qualification'];
    aadharFront = doc['aadhar_front'];
    aadharBack = doc['aadhar_back'];
  }
  // Convert to json
  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'email': email,
  //       'phone': contactNum,
  //       'address': address,
  //       'fathername': fathername,
  //       'mothername': mothername,
  //       'companyName': companyName,
  //       'dob': dob,
  //       'position': position,
  //     };
}
