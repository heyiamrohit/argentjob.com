// import 'package:flutter/material.dart';
// import 'package:tatkal_jobs_app/screens/add_job.dart';
// import 'package:tatkal_jobs_app/screens/job_posted.dart';

// class DrawerWidget extends StatelessWidget {
//   const DrawerWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             FlutterLogo(size: 200),
//             ListTile(
//                 leading: Icon(Icons.people),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Your Profile'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => ProfilePage()));
//                 }),
//             ListTile(
//                 leading: Icon(Icons.search),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Search Jobs'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => HomePage()));
//                 }),
//             ListTile(
//                 leading: Icon(Icons.exit_to_app),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Jobs Applied'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => JobsApplied()));
//                 }),
//             ListTile(
//                 leading: Icon(Icons.exit_to_app),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Logout'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => HomePage()));
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DrawerWidgetEmployer extends StatelessWidget {
//   const DrawerWidgetEmployer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             FlutterLogo(size: 200),
//             ListTile(
//                 leading: Icon(Icons.people),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Your Profile'),
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => ProfilePagePoster()));
//                 }),
//             ListTile(
//                 leading: Icon(Icons.cases),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Job Posted'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => JobPosted()));
//                 }),
//             ListTile(
//                 leading: Icon(Icons.exit_to_app),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Post a Job'),
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) => AddJob()));
//                 }),
//             ListTile(
//                 leading: Icon(Icons.exit_to_app),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('List of Applicants'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => Applicants(5)));
//                 }),
//             ListTile(
//                 leading: Icon(Icons.exit_to_app),
//                 trailing: Icon(Icons.chevron_right),
//                 title: Text('Logout'),
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => HomePage()));
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
