import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tatkal_jobs_app/models/user_profile.dart';

class AuthProvider with ChangeNotifier {
  late bool isAuthenticated ;
  bool userExists = false;

  UserModel user = UserModel(
      name: 'name',
      email: 'email',
      contactNum: '12',
      address: 'address',
      fathername: 'fathername',
      companyName: 'companyName',
      dob: DateTime.now(),
      position: 'position',
      companyAddress: 'Company',
      qualification: 'qual',
      experience: 'exp',
      userDp: 'https://picsum.photos/200',
      aadharFront: '',
      aadharBack: '');

  /*--------------------------- phone auth ---------------------------------------------------- */

  /*--------------------------- phone auth ---------------------------------------------------- */

  XFile? _imageFileList;

  /* ---------------------------START fetch user ---------------------------------------------------- */

  Future fetchUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    print("*******" + querySnapshot.docs.first.data().toString());
    // user = null;
    user = UserModel.fromDocument(querySnapshot.docs.first);
    print("*****dataaaa" + user.toString());
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    isAuthenticated = false;
    print('signout');
    notifyListeners();
  }
  /*--------------------------- END fetch user ---------------------------------------------------- */

  /*
  
  
  --------------------------- START update user ---------------------------------------------------- */

  Future updateuser(Map<String, Object> data) async {
    CollectionReference querySnapshot =
        await FirebaseFirestore.instance.collection('users');
    querySnapshot.doc(user.id).update(data);
    await fetchUser();
    notifyListeners();
  }
  /*--------------------------- END update user ---------------------------------------------------- */

  /*
 
 
  --------------------------- START register user ---------------------------------------------------- */

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future registeruser(
    String name,
    String fathersname,
    String email,
    String phoneno,
    String position,
    String address,
    Timestamp dob,
    String uid,
    String imgProfile,
    String imgAadharFront,
    String imgAadharBack,
    String experience,
    String qualification,
  ) async {
    CollectionReference querySnapshot =
        await FirebaseFirestore.instance.collection('users');
    querySnapshot.add({
      'name': name,
      'fathername': fathersname,
      'email': email,
      'phone': phoneno,
      'position': position,
      'address': address,
      'dob': dob,
      'user': FirebaseAuth.instance.currentUser!.uid.toString(),
      'company_name': '',
      'company_address': '',
      'aadhar_front': imgAadharFront,
      'aadhar_back': imgAadharBack,
      'profile_image': imgProfile,
      'experience':experience,
      'qualification':qualification,
    }).then((value) => isAuthenticated = true);
    // querySnapshot
    //     .doc('BCqf0tmGH56G7VmOUQVF')
    //     .update({'name': 'Stokes and Sons111', 'fathername': 'father'});

    notifyListeners();
  }

  // Future<void> checkUser(String phone) async {
  //   print("**** " + phone);
  //   userExists = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('phone', isEqualTo: phone)
  //       .get()
  //       .then((value) => value.docs.length > 0);
  //   print("***************" + userExists.toString());
  //   notifyListeners();
  // }

  /*--------------------------- END register user ---------------------------------------------------- */

  /*


 --------------------------- sinup ---------------------------------------------------- */

  // Future<void> signUp(String email, String phone, String name) async {
  //   print(email + phone + name);
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .add({'email': email, 'phone': phone, 'name': name});
  // }
  /*--------------------------- sinup ---------------------------------------------------- */
}





/**
 * query to delete 
   Future<void> deleteUser() async {
    await FirebaseFirestore.instance
        .collection('jobsapplied')
        .doc('94spLRSvKCnXKv454yE0')
        .delete();
    // users
    //     .doc('94spLRSvKCnXKv454yE0')
    //     .delete()
    //     .then((value) => print("User Deleted"))
    //     .catchError((error) => print("Failed to delete user: $error"));
    notifyListeners();
  }


*********************************************************  
**************** to update in firebase ******************
*********************************************************
  
 Future updateuser() async {
    CollectionReference querySnapshot =
        await FirebaseFirestore.instance.collection('users');
    querySnapshot
        .doc('BCqf0tmGH56G7VmOUQVF')
        .update({'name': 'Stokes and Sons111', 'fathername': 'father'});

    notifyListeners();
  }



 */