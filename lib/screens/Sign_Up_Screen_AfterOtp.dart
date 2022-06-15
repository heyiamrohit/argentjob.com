import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/providers/otpProvider.dart';
import 'package:tatkal_jobs_app/screens/All_Jobs_Screen.dart';
import 'package:tatkal_jobs_app/screens/Home_Screen.dart';
import 'package:tatkal_jobs_app/screens/sharedPrefrences/sharedPrfrnces.dart';

import 'sharedPrefrences/imagePicker.dart';

class SignUpOtp extends StatefulWidget {
  final String phoneNumber;
  SignUpOtp(this.phoneNumber);
  static const routeName = '/signupotpafter';

  @override
  _ProfilePageState createState() => _ProfilePageState(this.phoneNumber);
}

class _ProfilePageState extends State<SignUpOtp> {
  String phoneNumber;
  _ProfilePageState(this.phoneNumber);
  final _formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final nameController = TextEditingController();
  final fnameController = TextEditingController();
  final emailController = TextEditingController();
  var dobdate = DateTime.now();
  final posController = TextEditingController();
  final addressController = TextEditingController();
  final expController = TextEditingController();
  final qualController = TextEditingController();
  final _otpController = TextEditingController();
  bool isEnabled = true;
  String imageUserUrl = 'https://picsum.photos/200';
  String imageFrontUrl = 'https://picsum.photos/200';
  String imageBackUrl = 'https://picsum.photos/200';

  getAadharFrontlink(String imgUrl) {
    log("Here is image url: $imgUrl");
    setState(() {
      imageFrontUrl = imgUrl;
    });
  }

  getUserlink(String imgUrl) {
    log("Here is image url: $imgUrl");
    setState(() {
      imageUserUrl = imgUrl;
    });
  }

  getAadharBacklink(String imgUrl) {
    log("Here is image url: $imgUrl");
    setState(() {
      imageBackUrl = imgUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context, listen: false);
    // Provider.of<SharedPrefences>(context).addBoolToSF('isauthenticated', true);
    print("**********************" + this.phoneNumber);
    //File _image;
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(imageUserUrl),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImagePkr(
                                        getimageLink: getUserlink,
                                      )),
                            );
                          },
                          child: Text('Upload Image'))
                    ],
                  ),
                ),
                TextFormField(
                  enabled: isEnabled,
                  decoration: InputDecoration(labelText: "Full name"),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  enabled: isEnabled,
                  decoration: InputDecoration(labelText: "Father's name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Father's name";
                    }
                    return null;
                  },
                  controller: fnameController,
                ),
                TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    controller: emailController,
                    validator: (value) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!)) {
                        return "Enter Valid Email Id";
                      }
                      return null;
                    }),
                SizedBox(height: 5),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Date Of Birth'),
                    controller: dobController,
                    enabled: isEnabled,
                    onTap: () async {
                      DateTime date = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      date = (await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2010)))!;

                      dobController.text =
                          DateFormat('dd-MM-yyyy').format(date);
                      dobdate = date;
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.26,
                          height: 140,
                          child: Image.network(
                            imageFrontUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagePkr(
                                          getimageLink: getAadharFrontlink,
                                        )),
                              );
                            },
                            child: Text(
                              'Upload Aadhar Card (Front)',
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.26,
                          height: 140,
                          child: Image.network(
                            imageBackUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagePkr(
                                          getimageLink: getAadharBacklink,
                                        )),
                              );
                            },
                            child: Text(
                              'Upload Aadhar Card (Back)',
                              style: TextStyle(fontSize: 12),
                            )),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: 50, width: double.infinity),

                SizedBox(height: 50, width: double.infinity),
                TextFormField(
                  enabled: isEnabled,
                  decoration: InputDecoration(labelText: 'Position'),
                  controller: posController,
                ),
                TextFormField(
                  enabled: isEnabled,
                  decoration: InputDecoration(labelText: 'Permanent Address'),
                  controller: addressController,
                ),
                TextFormField(
                  enabled: isEnabled,
                  decoration: InputDecoration(labelText: "Qualification"),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return "Please enter Qualification";
                    }
                    return null;
                  },
                  controller: qualController,
                ),
                TextFormField(
                  enabled: isEnabled,
                  decoration: InputDecoration(labelText: "Experience"),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return "Please enter Experience";
                    }
                    return null;
                  },
                  controller: expController,
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (imageBackUrl == "https://picsum.photos/200" ||
                            imageFrontUrl == "https://picsum.photos/200" ||
                            imageUserUrl == "https://picsum.photos/200") {
                          AwesomeDialog(
                            dismissOnTouchOutside: false,
                            context: context,
                            dialogType: DialogType.INFO,
                            animType: AnimType.TOPSLIDE,
                            title: 'Please upload all required images',
                            // desc: 'Dialog desc',
                            // btnCancelOnPress: () {},
                            btnOkColor: Colors.blue,
                            btnOkOnPress: () {

                            },
                          )..show();
                        }
                        // Validate returns true if the form is valid, or false otherwise.
                        else if (_formKey.currentState!.validate()) {
                          Provider.of<ShardPrfnc>(context, listen: false)
                              .addBoolToSF("isauthenticated", true);
                          // SharedPreferences prefs =
                          //     await SharedPreferences.getInstance();
                          // await prefs.setBool("isauthenticated", true);
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('You are logged In')),
                          );
                          print('regit');
                          Provider.of<AuthProvider>(context, listen: false)
                              .registeruser(
                                  nameController.text,
                                  fnameController.text,
                                  emailController.text,
                                  FirebaseAuth.instance.currentUser!.phoneNumber
                                      .toString(),
                                  posController.text,
                                  addressController.text,
                                  Timestamp.fromDate(dobdate),
                                  FirebaseAuth.instance.currentUser!.uid
                                      .toString(),
                                  imageUserUrl,
                                  imageFrontUrl,
                                  imageBackUrl,
                                  qualController.text,
                                  expController.text)
                              .then((value) => prov.isAuthenticated = true)
                              .then((value) => Navigator.of(context)
                                  .pushReplacementNamed(IntroScreen.routeName));
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
