import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/models/user_profile.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';

class ApplicantProfile extends StatefulWidget {
  // const ProfilePage({Key? key}) : super(key: key);
  final UserModel userModel;
  ApplicantProfile(this.userModel);
  static const routeName = '/ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ApplicantProfile> {
  bool isEnabled = false;
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    final userModel = widget.userModel;
    final dobController = TextEditingController(
      text: format.format(userModel.dob),
    );
    final fnameController = TextEditingController(
      text: userModel.fathername,
    );
    final nameController = TextEditingController(
      text: userModel.name,
    );
    final mnameController = TextEditingController(
      text: userModel.userId,
    );
    final phoneController = TextEditingController(
      text: userModel.contactNum,
    );
    final emailController = TextEditingController(
      text: userModel.email,
    );
    final posController = TextEditingController(
      text: userModel.position,
    );
    final addressController = TextEditingController(
      text: userModel.address,
    );
    final companynameController = TextEditingController(
      text: userModel.companyName,
    );
    final expController = TextEditingController(
      text: userModel.experience,
    );
    final qualController = TextEditingController(
      text: userModel.qualification,
    );
    // final companyaddrController = TextEditingController(text: prov.user.address,);
    return Scaffold(
        appBar: AppBar(title: Text(userModel.name)),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Column(children: [
                  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Image.network(userModel.userDp),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userModel.name,
                                // textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 25)),
                            Text(userModel.position,
                                style: TextStyle(fontSize: 15)),
                            Text(userModel.email,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ])),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Full name",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(Icons.family_restroom),
                        prefixText: 'Mr.',
                        labelText: "Father's name"),
                    controller: fnameController,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: userModel.userId));
                    final snackBar = SnackBar(
                      content: const Text('User id copied to clipboard'),
                      backgroundColor: (Colors.black),
                    );
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: isEnabled,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.copy),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          prefixIcon: Icon(Icons.family_restroom),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          labelText: "User ID"),
                      // controller: mnameController,
                      initialValue: userModel.userId.substring(0, 10) + "...",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: false,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        labelText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone)),
                    controller: phoneController,
                    //initialValue: prov.user.contactNum.toString(),
                    // keyboardType:
                    // ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        prefixIcon: Icon(Icons.mail_outline),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        // suffixText: '.com',
                        labelText: 'Email Address'),
                    controller: emailController,
                    //initialValue: prov.user.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                          ),
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                          labelText: 'Date Of Birth'),
                      controller: dobController,
                      //initialValue: DateFormat('dd-MM-yyyy')
                      //    .format(prov.user.dob),
                      enabled: isEnabled,
                      onTap: () async {
                        DateTime date = DateTime(1900);
                        FocusScope.of(context).requestFocus(new FocusNode());

                        date = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100)))!;

                        dobController.text = date.toIso8601String();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(Icons.apartment_outlined),
                        labelText: 'Permanent Address'),
                    controller: addressController,
                    //initialValue: prov.user.address,
                    maxLines: 3,
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(Icons.archive),
                        labelText: "Experience"),
                    controller: expController,
                    //initialValue: prov.user.companyName,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(Icons.school),
                        labelText: "Qualification"),
                    controller: qualController,
                    //initialValue: prov.user.companyName,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        prefixIcon: Icon(Icons.account_balance_outlined),
                        labelText: "Company Name"),
                    controller: companynameController,
                    //initialValue: prov.user.companyName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(Icons.accessible),
                        labelText: 'Position'),
                    controller: posController,
                    //initialValue: prov.user.position,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: isEnabled,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(Icons.apartment_sharp),
                        labelText: "Company Address"),
                    controller: addressController,
                    //initialValue: prov.user.companyName,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
