// // import 'package:flutter/material.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// // import 'package:tatkal_jobs_app/commons/colors.dart';
// // import 'package:tatkal_jobs_app/data/jobs.dart';
// // import 'package:tatkal_jobs_app/models/jobs.dart';
// // import 'package:tatkal_jobs_app/widgets/drawer.dart';

// // import 'job_desc.dart';

// // class JobPosted extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
// //             child: TextFormField(
// //               decoration: InputDecoration(
// //                 prefixIcon: Icon(Icons.search),
// //                 prefixStyle: TextStyle(color: Colors.red),
// //                 // errorText: 'plesase enter valid phone no',
// //                 hintText: 'Search',

// //                 // border: OutlineInputBorder(
// //                 //     borderSide: BorderSide(color: MyColors.primary_Color)),
// //                 // enabledBorder: OutlineInputBorder(
// //                 //   borderRadius: BorderRadius.all(Radius.circular(40.0)),
// //                 //   borderSide: BorderSide(color: Colors.grey, width: 2),
// //                 // ),
// //                 // focusedBorder: OutlineInputBorder(
// //                 //   borderRadius: BorderRadius.all(Radius.circular(40.0)),
// //                 //   borderSide: BorderSide(color: MyColors.primary_Color,width: 1),
// //                 // ),
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: joblist.length,
// //               itemBuilder: (context, index) {
// //                 return JobListWidget(
// //                     joblist[index].title,
// //                     joblist[index].postedby,
// //                     joblist[index].description,
// //                     joblist[index].location,
// //                     joblist[index].skills,
// //                     index);
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //       drawer: DrawerWidgetEmployer(),
// //     );
// //   }
// // }

// // class JobListWidget extends StatelessWidget {
// //   String jobName;
// //   String postedBy;
// //   String jobDescription;
// //   String jobLocation;
// //   final int index;
// //   List<String> skills;
// //   JobListWidget(this.jobName, this.postedBy, this.jobDescription,
// //       this.jobLocation, this.skills, this.index);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
// //       child: Card(
// //         elevation: 12,
// //         child: Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 jobName,
// //                 style: TextStyle(fontSize: 20),
// //               ),
// //               SizedBox(height: 5),
// //               Text(
// //                 jobDescription,
// //                 overflow: TextOverflow.ellipsis,
// //                 style: TextStyle(fontSize: 17, color: Colors.blue),
// //               ),
// //               SizedBox(height: 10),
// //               JobDescRows(FontAwesomeIcons.ad, skills.join()),
// //               SizedBox(height: 5),
// //               JobDescRows(FontAwesomeIcons.joint, jobLocation),
// //               SizedBox(height: 5),
// //               JobDescRows(FontAwesomeIcons.houseUser, postedBy),
// //               Row(
// //                 children: [
// //                   Spacer(),
// //                   Container(
// //                     // width: double.infinity,
// //                     width: MediaQuery.of(context).size.width * 0.2,
// //                     child: TextButton(
// //                         child: Text('Inactive',
// //                             style: TextStyle(
// //                                 color: MyColors.primary_Color,
// //                                 fontSize: 16)),
// //                         style: ButtonStyle(
// //                             padding: MaterialStateProperty.all<EdgeInsets>(
// //                                 EdgeInsets.all(4)),
// //                             // foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
// //                             foregroundColor:
// //                                 MaterialStateProperty.all<Color>(
// //                               Theme.of(context).errorColor,
// //                             ),
// //                             shape: MaterialStateProperty.all<
// //                                     RoundedRectangleBorder>(
// //                                 RoundedRectangleBorder(
// //                                     borderRadius:
// //                                         BorderRadius.circular(18.0),
// //                                     side: BorderSide(
// //                                       color: Theme.of(context).primaryColor,
// //                                     )))),
// //                         onPressed: () {
// //                           Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (contect) =>
// //                                       JobDetailWidget(index)));
// //                         }),
// //                   ),
// //                   SizedBox(width: 10),
// //                   Container(
// //                     // width: double.infinity,
// //                     width: MediaQuery.of(context).size.width * 0.2,
// //                     child: TextButton(
// //                         child: Text('Edit',
// //                             style: TextStyle(
// //                                 color: MyColors.primary_Color,
// //                                 fontSize: 16)),
// //                         style: ButtonStyle(
// //                             padding: MaterialStateProperty.all<EdgeInsets>(
// //                                 EdgeInsets.all(4)),
// //                             // foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
// //                             foregroundColor:
// //                                 MaterialStateProperty.all<Color>(
// //                               Theme.of(context).errorColor,
// //                             ),
// //                             shape: MaterialStateProperty.all<
// //                                     RoundedRectangleBorder>(
// //                                 RoundedRectangleBorder(
// //                                     borderRadius:
// //                                         BorderRadius.circular(18.0),
// //                                     side: BorderSide(
// //                                       color: Theme.of(context).primaryColor,
// //                                     )))),
// //                         onPressed: () {
// //                           Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (contect) =>
// //                                       JobDetailWidget(index)));
// //                         }),
// //                   ),
// //                 ],
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class JobDescRows extends StatelessWidget {
// //   IconData icon;
// //   String postedBy;
// //   JobDescRows(this.icon, this.postedBy);
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(12.0),
// //           child: Icon(
// //             icon,
// //             size: 16,
// //           ),
// //         ),
// //         SizedBox(width: 5),
// //         Text(
// //           postedBy,
// //           style: TextStyle(fontSize: 15),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:tatkal_jobs_app/commons/colors.dart';
// import 'package:tatkal_jobs_app/data/jobs.dart';
// import 'package:tatkal_jobs_app/models/jobs.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';

// import '../Job_Description_Screen.dart';

// class JobPosted extends StatelessWidget {
//   static const routeName = '/jobposted';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
//             child: TextFormField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 prefixStyle: TextStyle(color: Colors.red),
//                 // errorText: 'plesase enter valid phone no',
//                 hintText: 'Search',

//                 // border: OutlineInputBorder(
//                 //     borderSide: BorderSide(color: MyColors.primary_Color)),
//                 // enabledBorder: OutlineInputBorder(
//                 //   borderRadius: BorderRadius.all(Radius.circular(40.0)),
//                 //   borderSide: BorderSide(color: Colors.grey, width: 2),
//                 // ),
//                 // focusedBorder: OutlineInputBorder(
//                 //   borderRadius: BorderRadius.all(Radius.circular(40.0)),
//                 //   borderSide: BorderSide(color: MyColors.primary_Color,width: 1),
//                 // ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: joblist.length,
//               itemBuilder: (context, index) {
//                 return JobListWidget(
//                     joblist[index].title,
//                     joblist[index].postedby,
//                     joblist[index].description,
//                     joblist[index].location,
//                     joblist[index].skills,
//                     index);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class JobListWidget extends StatelessWidget {
//   String jobName;
//   String postedBy;
//   String jobDescription;
//   String jobLocation;
//   final int index;
//   List<String> skills;
//   JobListWidget(this.jobName, this.postedBy, this.jobDescription,
//       this.jobLocation, this.skills, this.index);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//       child: Card(
//         elevation: 12,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 jobName,
//                 style: TextStyle(fontSize: 20),
//               ),
//               SizedBox(height: 5),
//               Text(
//                 jobDescription,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(fontSize: 17, color: Colors.blue),
//               ),
//               SizedBox(height: 10),
//               JobDescRows(FontAwesomeIcons.ad, skills.join()),
//               SizedBox(height: 5),
//               JobDescRows(FontAwesomeIcons.joint, jobLocation),
//               SizedBox(height: 5),
//               JobDescRows(FontAwesomeIcons.houseUser, postedBy),
//               Row(
//                 children: [
//                   Spacer(),
//                   Container(
//                     // width: double.infinity,
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     child: TextButton(
//                         child: Text('Inactive',
//                             style: TextStyle(
//                                 color: MyColors.primary_Color, fontSize: 16)),
//                         style: ButtonStyle(
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                                 EdgeInsets.all(4)),
//                             // foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                             foregroundColor: MaterialStateProperty.all<Color>(
//                               Theme.of(context).errorColor,
//                             ),
//                             shape: MaterialStateProperty
//                                 .all<RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(18.0),
//                                         side: BorderSide(
//                                           color: Theme.of(context).primaryColor,
//                                         )))),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (contect) =>
//                                       JobDetailWidget(index)));
//                         }),
//                   ),
//                   SizedBox(width: 10),
//                   Container(
//                     // width: double.infinity,
//                     width: MediaQuery.of(context).size.width * 0.2,
//                     child: TextButton(
//                         child: Text('Edit',
//                             style: TextStyle(
//                                 color: MyColors.primary_Color, fontSize: 16)),
//                         style: ButtonStyle(
//                             padding: MaterialStateProperty.all<EdgeInsets>(
//                                 EdgeInsets.all(4)),
//                             // foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                             foregroundColor: MaterialStateProperty.all<Color>(
//                               Theme.of(context).errorColor,
//                             ),
//                             shape: MaterialStateProperty
//                                 .all<RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(18.0),
//                                         side: BorderSide(
//                                           color: Theme.of(context).primaryColor,
//                                         )))),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (contect) =>
//                                       JobDetailWidget(index)));
//                         }),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class JobDescRows extends StatelessWidget {
//   IconData icon;
//   String postedBy;
//   JobDescRows(this.icon, this.postedBy);
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Icon(
//             icon,
//             size: 16,
//           ),
//         ),
//         SizedBox(width: 5),
//         Text(
//           postedBy,
//           style: TextStyle(fontSize: 15),
//         ),
//       ],
//     );
//   }
// }
