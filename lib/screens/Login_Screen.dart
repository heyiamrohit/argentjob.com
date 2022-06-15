import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/screens/Home_Screen.dart';
import 'package:tatkal_jobs_app/screens/SignUp_Screen.dart';
import 'package:tatkal_jobs_app/screens/sharedPrefrences/sharedPrfrnces.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login_Screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  bool isloading = false;
  bool isotploading = false;
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final authProv = Provider.of<AuthProvider>(context, listen: false);
    DateTime pre_backpress = DateTime.now();
    _auth
        .verifyPhoneNumber(
            phoneNumber: phone,
            timeout: Duration(seconds: 60),
            verificationCompleted: (AuthCredential credential) async {
              Navigator.of(context).pop();

              final result =
                  await _auth.signInWithCredential(credential).catchError((e) {
                print("********************" + e.toString());
                setState(() {
                  isloading = false;
                });
                const snackBar = SnackBar(content: Text('Invalid OTP'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });

              final user = result.user;

              if (user != null) {
                authProv.isAuthenticated = true;
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool("isauthenticated", true);
                Provider.of<ShardPrfnc>(context, listen: false)
                    .addBoolToSF("isauthenticated", true);
                Navigator.pushReplacementNamed(context, IntroScreen.routeName);
              } else {
                print("Error");
              }

              //This callback would gets called when verification is done auto maticlly
            },
            verificationFailed: (FirebaseAuthException exception) {
              print(exception);
              print("********************" + exception.toString());
              setState(() {
                isloading = false;
              });
              const snackBar = SnackBar(
                  content: Text('An error occured while logging you In'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            codeSent: (String verificationId, int? forceResendingToken) {
              setState(() {
                isloading = false;
              });
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return WillPopScope(
                        onWillPop: () async {
                          final timegap =
                              DateTime.now().difference(pre_backpress);
                          final cantExit = timegap >= Duration(seconds: 2);
                          pre_backpress = DateTime.now();
                          if (cantExit) {
                            //show snackbar
                            final snack = SnackBar(
                              content: Text('Press Back button again to Exit'),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                            return false; // false will do nothing when back press
                          } else {
                            return true; // true will exit the app
                          }
                        },
                        child: AlertDialog(
                          title: Text("Enter the OTP"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'enter 6 digits';
                                  }
                                  return null;
                                },
                                maxLength: 6,
                                controller: _codeController,
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: isotploading
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text("Confirm"),
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () async {
                                setState(() {
                                  isotploading = true;
                                });
                                final code = _codeController.text.trim();
                                AuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        smsCode: code,
                                        verificationId: verificationId);
                                //    PhoneAuthProvider.getCredential(
                                //        verificationId: verificationId, smsCode: code);
                                final result = await _auth
                                    .signInWithCredential(credential)
                                    .catchError((e) {
                                  print("********************" + e.toString());
                                  setState(() {
                                    isloading = false;
                                  });
                                  const snackBar =
                                      SnackBar(content: Text('Invalid OTP'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });

                                //User? user = result.user;
                                User? user = _auth.currentUser;
                                print("*********************** " +
                                    user.toString());

                                if (user != null) {
                                  Provider.of<ShardPrfnc>(context,
                                          listen: false)
                                      .addBoolToSF("isauthenticated", true);
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setBool("isauthenticated", true);
                                  authProv.isAuthenticated = true;
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      IntroScreen.routeName, (route) => false);
                                } else {
                                  setState(() {
                                    isloading = false;
                                  });
                                  print("********************** Error");
                                  const snackBar =
                                      SnackBar(content: Text('Invalid OTP'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                            ),
                          ],
                        ));
                  });
            },
            codeAutoRetrievalTimeout: (_) {})
        .onError((error, stackTrace) {
      setState(() {
        isloading = false;
      });
      print("***********" + error.toString());
    });
    return true;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                    validator: (val) {
                      if (val!.length < 10) {
                        return 'enter 10 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixText: '+91',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey)),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile Number"),
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: isloading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text("LOGIN"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isloading = true;
                          });
                          final phone = '+91' + _phoneController.text.trim();
                          bool exists = await FirebaseFirestore.instance
                              .collection('users')
                              .where('phone', isEqualTo: phone)
                              .get()
                              .then((value) => value.docs.length > 0);
                          if (exists) {
                            setState(() {
                              isloading = true;
                            });
                            loginUser(phone, context);
                          } else {
                            // showAlertDialog(context);
                            setState(() {
                              isloading = false;
                            });
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Error',
                              desc: 'You need to register first.',
                              // btnCancelOnPress: () {},
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {},
                            )..show();
                          }
                        }
                      },
                      color: Colors.blue,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              SignUpScreen.routeName,
                            );
                          },
                          child: Text('Register')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
