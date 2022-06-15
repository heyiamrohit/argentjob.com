// // import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tatkal_jobs_app/providers/otpProvider.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/Sign_Up_Screen.dart';

// import '../All_Jobs_Screen.dart';
// import '../Sign_Up_Screen_AfterOtp.dart';
// // import 'package:tatkal_jobs_app/models/jobs.dart';
// // import 'package:tatkal_jobs_app/screens/All_Jobs_Screen.dart';
// // import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';

// class SignUpScreen extends StatefulWidget {
//   // const Login({Key? key}) : super(key: key);
//   static const routeName = '/signupscreen';

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final _otpController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final otpprov = Provider.of<OtpProvider>(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Sign Up'),
//         ),
//         body: Padding(
//             padding: EdgeInsets.all(10),
//             child: ListView(
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.all(10),
//                   child: FlutterLogo(
//                     size: 150,
//                   ),
//                 ),
//                 Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'TATKAL JOBS',
//                       style: TextStyle(
//                           color: Color.fromRGBO(0, 88, 122, 1),
//                           fontWeight: FontWeight.w500,
//                           fontSize: 30),
//                     )),
//                 Container(
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(fontSize: 20),
//                     )),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   child: TextField(
//                     keyboardType: TextInputType.phone,
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       prefixText: '+91',
//                       border: OutlineInputBorder(),
//                       labelText: 'Contact Number',
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   height: 50,
//                   padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                         shape:
//                             MaterialStateProperty.all<RoundedRectangleBorder>(
//                                 RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     side: BorderSide(color: Colors.blue)))),
//                     child: Text(
//                       'Sign Up',
//                       style: TextStyle(
//                           color: Colors.white, backgroundColor: Colors.blue),
//                     ),
//                     onPressed: () {
//                       print(nameController.text);
//                       otpprov.getNumber(nameController.text.toString());
//                       print(nameController.text);
//                       otpprov.signIn();
//                       showDialog(
//                           context: context,
//                           barrierDismissible: false,
//                           builder: (context) {
//                             return AlertDialog(
//                                 title: Text('Enter OTP'),
//                                 content: TextField(
//                                   controller: _otpController,
//                                   keyboardType: TextInputType.number,
//                                   decoration:
//                                       InputDecoration(hintText: "123456"),
//                                 ),
//                                 actions: <Widget>[
//                                   TextButton(
//                                       child: Text(
//                                         'Resent Otp',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       style: TextButton.styleFrom(
//                                         backgroundColor:
//                                             Theme.of(context).primaryColor,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                       ),
//                                       onPressed: () => otpprov.signIn()),
//                                   TextButton(
//                                       child: Text(
//                                         'Submit Otp',
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       style: TextButton.styleFrom(
//                                         backgroundColor:
//                                             Theme.of(context).primaryColor,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                       ),
//                                       onPressed: () {
//                                         otpprov.get_otp_from_user(
//                                             _otpController.text);
//                                         otpprov.login();
//                                         otpprov.isUserLoggedIn().then((_) {
//                                           if (otpprov.isAuth == true) {
//                                             Navigator.pushNamed(
//                                                 context, SignUpOtp.routeName);
//                                           } else {
//                                             const snackBar = SnackBar(
//                                                 content: Text('Invalid OTP'));
//                                             ScaffoldMessenger.of(context)
//                                                 .showSnackBar(snackBar);
//                                           }
//                                         });
//                                       })
//                                 ]);
//                             // prov.signUp(emailController.text,
//                             //     phoneController.text, fnameController.text);
//                           });
//                     },
//                   ),
//                 ),
//               ],
//             )));
//   }
// }
