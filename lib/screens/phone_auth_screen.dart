// import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/providers/otpProvider.dart';
import 'package:tatkal_jobs_app/screens/Home_Screen.dart';
// import 'package:tatkal_jobs_app/models/jobs.dart';
// import 'package:tatkal_jobs_app/screens/All_Jobs_Screen.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';

class PhoneAuthScreen extends StatefulWidget {
  // const PhoneAuthScreen({Key? key}) : super(key: key);
  static const routeName = '/PhoneAuthScreen';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PhoneAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<OtpProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('PhoneAuthScreen'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: FlutterLogo(
                    size: 150,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'TATKAL JOBS',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 88, 122, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                //   child: TextField(
                //     obscureText: true,
                //     controller: passwordController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'otp',
                //     ),
                //   ),
                // ),
                // PinEntryTextField(
                //   fields: 6,
                //   onSubmit: (text) {

                //   },
                // ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.blue)))),
                      child: Text(
                        'Get OTP',
                        style: TextStyle(
                            color: Colors.white, backgroundColor: Colors.blue),
                      ),
                      onPressed: () {
                        print(nameController.text);
                        print(passwordController.text);
                        prov.getNumber(nameController.text);
                        prov.signIn().then((value) => Navigator.pushNamed(
                            context, IntroScreen.routeName));
                      },
                    )),
                // Container(
                //     child: Row(
                //   children: <Widget>[
                //     Text('Dont have account?'),
                //     TextButton(
                //       child: Text(
                //         'Register',
                //       ),
                //       onPressed: () {
                //         //signup screen
                //       },
                //     )
                //   ],
                //   mainAxisAlignment: MainAxisAlignment.center,
                // ))
              ],
            )));
  }
}
