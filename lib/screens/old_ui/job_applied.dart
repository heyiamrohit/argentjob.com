// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:tatkal_jobs_app/data/jobs.dart';
// import 'package:tatkal_jobs_app/models/jobs.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';

// import '../Job_Description_Screen.dart';

// class JobsApplied extends StatelessWidget {
//   static const routeName = '/job-applied';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Jobs Applied"),
//       ),
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
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blue)),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                   borderSide: BorderSide(color: Colors.amber, width: 2),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
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
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.search),
//       ),
//     );
//   }
// }

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
//         elevation: 2,
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
//               JobDescRows(Icons.add_task, skills.join()),
//               SizedBox(height: 5),
//               JobDescRows(Icons.location_on, jobLocation),
//               SizedBox(height: 5),
//               JobDescRows(Icons.apartment, postedBy),
//               Row(
//                 children: [
//                   Spacer(),
//                   TextButton(
//                       style: TextButton.styleFrom(
//                           primary: Colors.white, backgroundColor: Colors.red),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (contect) => JobDetailWidget(index)));
//                       },
//                       child: Text('Rejected')),
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
//         Icon(
//           icon,
//           size: 16,
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
