import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';

class ProfileScreen extends StatefulWidget {
  // const ProfilePage({Key? key}) : super(key: key);
  static const routeName = '/ProfilePage';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
  bool isEnabled = false;
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    final fnameController = TextEditingController(
      text: prov.user.fathername,
    );
    final nameController = TextEditingController(
      text: prov.user.name,
    );
    DateTime dobdate = prov.user.dob;
    final mnameController = TextEditingController();
    final phoneController = TextEditingController(
      text: prov.user.contactNum,
    );
    final emailController = TextEditingController(
      text: prov.user.email,
    );
    final posController = TextEditingController(
      text: prov.user.position,
    );
    final addressController = TextEditingController(
      text: prov.user.address,
    );
    final companynameController = TextEditingController(
      text: prov.user.companyName,
    );
    final companyAddressController = TextEditingController(
      text: prov.user.companyAddress,
    );
    final expController = TextEditingController(
      text: prov.user.experience,
    );
    final qualController = TextEditingController(
      text: prov.user.qualification,
    );
    final dobController = TextEditingController(
      text: format.format(prov.user.dob),
    );
    String id = FirebaseAuth.instance.currentUser!.uid.toString();
    // final companyaddrController = TextEditingController(text: prov.user.address,);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: isEnabled ? Icon(Icons.done_all_outlined) : Icon(Icons.edit),
            onPressed: () {
              isEnabled
                  ? Provider.of<AuthProvider>(context, listen: false)
                      .updateuser({
                      'name': nameController.text,
                      'fathername': fnameController.text,
                      'phone': phoneController.text,
                      'email': emailController.text,
                      'position': posController.text,
                      'address': addressController.text,
                      'dob': Timestamp.fromDate(dobdate),
                      'company_name': companynameController.text,
                      'company_address': companyAddressController.text,
                      'qualification': qualController.text,
                      'experience': expController.text
                    })
                  : null;
              setState(() {
                isEnabled = !isEnabled;
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: prov.fetchUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("********error");
              print(snapshot.error);
              return Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              nameController.text = prov.user.name;
              final imgUrl = prov.user.userDp;
              fnameController.text = prov.user.fathername;
              mnameController.text = prov.user.userId;
              phoneController.text = prov.user.contactNum;
              addressController.text = prov.user.address;
              emailController.text = prov.user.email;
              posController.text = prov.user.position;
              companynameController.text = prov.user.companyName;
              companyAddressController.text = prov.user.companyAddress;
              qualController.text = prov.user.qualification;
              expController.text = prov.user.experience;
              // dobController.text = format.format(prov.user.dob);
              return SingleChildScrollView(
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
                              child: Image.network(imgUrl),
                            ),
                            Spacer(
                                //flex: 2,
                                ),
                            Container(
                              // color: Colors.red,
                              // alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prov.user.name,
                                      // textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 25)),
                                  Text(prov.user.position,
                                      style: TextStyle(fontSize: 15)),
                                  Text(prov.user.email,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          controller: nameController,
                          // initialValue: prov.user.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: isEnabled,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              // prefixIcon: Icon(Icons.male_outlined),
                              prefixIcon: Icon(Icons.family_restroom),
                              prefixText: 'Mr.',
                              labelText: "Father's name"),
                          controller: fnameController,
                          //initialValue: prov.user.fathername,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: id));
                          final snackBar = SnackBar(
                            content: const Text('User Id copied'),
                            backgroundColor: (Colors.black),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.copy),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2),
                                ),
                                prefixIcon: Icon(Icons.card_membership),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                labelText: "User ID"),
                            // controller: mnameController,
                            initialValue: id.substring(0, 10) + "...",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              prefixIcon: Icon(Icons.mail_outline),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                      Row(
                        children: [
                          SizedBox(width: MediaQuery.of(context).size.width*0.05),
                          Image.network(
                            prov.user.aadharFront,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                          Spacer(),
                          Image.network(
                            prov.user.aadharBack,
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.05),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Center(child: Text('Aadhar Card Image')),
                      SizedBox(height: 10,),
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
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              date = (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2010)))!;
                              dobController.text = format.format(date);
                              dobdate = date;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          enabled: isEnabled,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              prefixIcon: Icon(Icons.apartment_sharp),
                              labelText: "Company Address"),
                          controller: companyAddressController,
                          //initialValue: prov.user.companyName,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          }),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.save),
      //     onPressed: () async {
      //       setState(() {
      //         isEnabled = !isEnabled;
      //       });
      //       await Provider.of<AuthProvider>(context, listen: false)
      //           .updateuser();
      //     }),
    );
  }
}
