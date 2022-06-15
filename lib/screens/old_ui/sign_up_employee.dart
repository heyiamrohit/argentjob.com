// import 'dart:io';

// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:tatkal_jobs_app/models/jobs.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/homescreen.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';

// import 'job_posted.dart';

// class SignUpEmployee extends StatefulWidget {
//   const SignUpEmployee({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<SignUpEmployee> {
//   final _formKey = GlobalKey<FormState>();
//   final dobController = TextEditingController();
//   final fnameController = TextEditingController();
//   final mnameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final posController = TextEditingController();
//   final addressController = TextEditingController();
//   bool isEnabled = true;

//   @override
//   Widget build(BuildContext context) {
//     //File _image;
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign Up')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Center(
//                   child: Column(
//                     children: [
//                       TextButton(
//                           onPressed: () {},
//                           child: Text('Sign Up using Google')),
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             'https://images.pexels.com/photos/8536926/pexels-photo-8536926.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260'),
//                         radius: 50,
//                       ),
//                       TextButton(onPressed: () {}, child: Text('Upload Image'))
//                     ],
//                   ),
//                 ),
//                 TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(labelText: "Full name"),
//                   controller: fnameController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter some text';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(labelText: "Father's name"),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Please enter Father's name";
//                     }
//                     return null;
//                   },
//                   controller: fnameController,
//                 ),
//                 TextFormField(
//                     enabled: isEnabled,
//                     decoration: InputDecoration(labelText: "Mother's name"),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter Mother's name";
//                       }
//                       return null;
//                     },
//                     controller: mnameController),
//                 TextFormField(
//                     enabled: isEnabled,
//                     decoration: InputDecoration(labelText: 'Phone Number'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter Phone Number";
//                       }
//                       return null;
//                     },
//                     controller: phoneController),
//                 TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(labelText: 'Email Address'),
//                   controller: emailController,
//                 ),
//                 TextFormField(
//                     decoration: InputDecoration(labelText: 'Date Of Birth'),
//                     controller: dobController,
//                     enabled: isEnabled,
//                     onTap: () async {
//                       DateTime date = DateTime(1900);
//                       FocusScope.of(context).requestFocus(new FocusNode());

//                       date = (await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1900),
//                           lastDate: DateTime(2100)))!;

//                       dobController.text = date.toIso8601String();
//                     }),
//                 Text(
//                   'Upload Aadhar Card (Front)',
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 SizedBox(height: 50, width: double.infinity),
//                 Text(
//                   'Upload Aadhar Card (Back)',
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 SizedBox(height: 50, width: double.infinity),
//                 TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(labelText: 'Company Name'),
//                   controller: posController,
//                 ),
//                 TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(labelText: 'Company Location'),
//                   controller: posController,
//                 ),
//                 TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(labelText: 'Position'),
//                   controller: posController,
//                 ),
//                 TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(labelText: 'Permanent Address'),
//                   controller: addressController,
//                 ),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Validate returns true if the form is valid, or false otherwise.
//                       if (_formKey.currentState!.validate()) {
//                         // If the form is valid, display a snackbar. In the real world,
//                         // you'd often call a server or save the information in a database.
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Processing Data')),
//                         );
                        
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => JobPosted()));
//                       }
//                     },
//                     child: const Text('Submit'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
