import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/screens/Home_Screen.dart';
import 'package:tatkal_jobs_app/screens/Login_Screen.dart';
import 'package:tatkal_jobs_app/screens/Sign_Up_Screen_AfterOtp.dart';
import 'package:tatkal_jobs_app/screens/alert_dialog.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signup';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final _phoneController = TextEditingController();
  bool isloading = false;
  bool isotploading = false;
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final authProv = Provider.of<AuthProvider>(context, listen: false);

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          final result = await _auth.signInWithCredential(credential);

          final user = result.user;

          if (user != null) {
            Navigator.pushNamed(context, SignUpOtp.routeName, arguments: phone);
          } else {
            print("Error");
            setState(() {
              isloading = false;
            });
            AwesomeDialog(
              context: context, showCloseIcon: true,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE, //awesome_dialog: ^2.1.1
              title: "Error",
              // desc: 'Dialog description here.............',
              // btnCancelOnPress: () {},
              btnOkText: 'Login',
              btnOkColor: Theme.of(context).primaryColor,
              btnOkOnPress: () {},
            ).show();
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
          print("********************" + exception.toString());
          setState(() {
            isloading = false;
          });
          const snackBar =
              SnackBar(content: Text('An error occured while logging you In'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            isloading = false;
          });
          DateTime pre_backpress = DateTime.now();
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return WillPopScope(
                    onWillPop: () async {
                      final timegap = DateTime.now().difference(pre_backpress);
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
                      title: Text("Give the code?"),
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
                              AwesomeDialog(
                                context: context, showCloseIcon: true,
                                dialogType: DialogType.ERROR,
                                animType: AnimType
                                    .BOTTOMSLIDE, //awesome_dialog: ^2.1.1
                                title: "Error",
                                btnOkText: 'Login',
                                btnOkColor: Theme.of(context).primaryColor,
                                btnOkOnPress: () {},
                              ).show();
                              const snackBar =
                                  SnackBar(content: Text('Invalid OTP'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });

                            //User? user = result.user;
                            User? user = _auth.currentUser;
                            print("*********************** " + user.toString());

                            if (user != null) {
                              Navigator.pushNamed(context, SignUpOtp.routeName, arguments: phone);
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
        codeAutoRetrievalTimeout: (_) {});
    return true;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*--------------------------- to dismiss virtual keyboard ---------------------------------------------------- */

        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
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
                      "Register",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 36,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 10) {
                          return 'enter 10 digits';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                          prefixText: '+91',
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
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
                            : Text("REGISTER"),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(16),
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            final phone = '+91' + _phoneController.text.trim();
                            bool exists = await FirebaseFirestore.instance
                                .collection('users')
                                .where('phone', isEqualTo: phone)
                                .get()
                                .then((value) => value.docs.length > 0);
                            if (exists) {
                              setState(() {
                                isloading = false;
                              });
                              // showAlertDialog(context);
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.ERROR,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'An account already exists with this number.',
                                btnOkColor: Colors.red,
                                btnOkOnPress: () {},
                              )..show();
                            } else {
                              setState(() {
                                isloading = true;
                              });
                              loginUser(phone, context);
                            }
                          }
                        },
                        color: Colors.blue,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            LoginScreen.routeName,
                            // arguments: product.id
                          );
                        },
                        child: Text('Login')),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
