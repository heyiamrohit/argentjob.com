// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:tatkal_jobs_app/providers/auth.dart';

// class ProfilePagePoster extends StatefulWidget {
//   // const ProfilePagePoster({Key? key}) : super(key: key);
//   static const routeName = '/ProfilePagePoster';

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePagePoster> {
//   final dobController = TextEditingController();
//   final fnameController = TextEditingController();
//   final mnameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final posController = TextEditingController();
//   final addressController = TextEditingController();
//   final companynameController = TextEditingController();
//   final companyaddrController = TextEditingController();
//   bool isEnabled = false;

//   @override
//   Widget build(BuildContext context) {
//     final data = Provider.of<AuthProvider>(context, listen: false);
//     var user = data.userDetails;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//         actions: [
//           IconButton(
//             icon: isEnabled ? Icon(Icons.done_all_outlined) : Icon(Icons.edit),
//             onPressed: () {
//               setState(() {
//                 isEnabled = !isEnabled;
//               });
//             },
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                   child: Column(children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       // ch
//                       radius: 50,
//                     ),
//                     Spacer(
//                         //flex: 2,
//                         ),
//                     Container(
//                       // color: Colors.red,
//                       // alignment: Alignment.centerLeft,
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       child: Column(
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(user.name,
//                               // textAlign: TextAlign.left,
//                               style: TextStyle(fontSize: 25)),
//                           Text(user.position, style: TextStyle(fontSize: 15)),
//                           Text(user.email, style: TextStyle(fontSize: 15)),
//                         ],
//                       ),
//                     ),
//                     //decoration: TextDecoration.underline,
//                     //decorationStyle: TextDecorationStyle.solid,
//                   ],
//                 ),
//                 SizedBox(height: 20),
//               ])),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.person),
//                     labelText: "Name",
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                       borderSide: BorderSide(color: Colors.grey, width: 2),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       borderSide: BorderSide(
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ),
//                   // controller: fnameController,
//                   initialValue: user.name,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       // prefixIcon: Icon(Icons.male_outlined),
//                       prefixIcon: Icon(Icons.family_restroom),
//                       prefixText: 'Mr.',
//                       labelText: "Father's name"),
//                   // controller: fnameController,
//                   initialValue: user.fathername,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       prefixIcon: Icon(Icons.family_restroom),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       prefixText: 'Mrs.',
//                       labelText: "Mother's name"),
//                   // controller: mnameController

//                   initialValue: user.mothername,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       labelText: 'Phone Number',
//                       prefixIcon: Icon(Icons.phone)),
//                   // controller: phoneController
//                   initialValue: user.contactNum.toString(),
//                   // keyboardType:
//                   // ,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       prefixIcon: Icon(Icons.mail_outline),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       // suffixText: '.com',
//                       labelText: 'Email Address'),
//                   // controller: emailController,
//                   initialValue: user.email,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                     decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                           borderSide: BorderSide(color: Colors.grey, width: 2),
//                         ),
//                         prefixIcon: Icon(Icons.calendar_today_outlined),
//                         labelText: 'Date Of Birth'),
//                     // controller: dobController,
//                     initialValue: DateFormat('dd-MM-yyyy').format(user.dob),
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
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       prefixIcon: Icon(Icons.apartment_outlined),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       labelText: 'Permanent Address'),
//                   // controller: addressController,
//                   initialValue: user.address,
//                   maxLines: 3,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       prefixIcon: Icon(Icons.account_balance_outlined),
//                       labelText: "Company Name"),
//                   // controller: companynameController,
//                   initialValue: user.companyName,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       prefixIcon: Icon(Icons.accessible),
//                       labelText: 'Position'),
//                   // controller: posController,
//                   initialValue: user.position,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   enabled: isEnabled,
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                         borderSide: BorderSide(color: Colors.grey, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         borderSide: BorderSide(
//                           color: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       prefixIcon: Icon(Icons.apartment_sharp),
//                       labelText: "Company Address"),
//                   // controller: companyaddrController,
//                   initialValue: user.companyName,
//                   maxLines: 2,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }