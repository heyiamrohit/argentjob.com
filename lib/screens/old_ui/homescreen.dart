// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:tatkal_jobs_app/commons/colors.dart';
// // import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:tatkal_jobs_app/data/jobs.dart';
// import 'package:tatkal_jobs_app/screens/Post_Job_Screen.dart';
// import 'package:tatkal_jobs_app/screens/Home_Screen.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/poster_profile.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/sign_up_employee.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/sign_up_seeker.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../Job_Description_Screen.dart';
// import 'job_posted.dart';

// class HomePage extends StatefulWidget {
//   // const HomePage({Key key}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // int _currentTabIndex = 0;
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
//   // ignore: unused_field
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Search',
//       style: optionStyle,
//     ),
//     Text(
//       'Profile',
//       style: optionStyle,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final _kTabPages = <Widget>[
//       IntroScreen(),
//       JobPosted(),
//       //AddJob(),
//       ProfilePagePoster(),
//       // ProfilePagePoster(),
//     ];

//     return Scaffold(
//       // appBar: AppBar(
//       //   // backgroundColor: MyColors.primary_Color,
//       //   title: Text(
//       //     'Tatkal Jobs',
//       //     style: TextStyle(
//       //       fontFamily: "poppins",
//       //     ),
//       //   ),
//       // ),
//       body: _kTabPages[_selectedIndex],
//       // backgroundColor: MyColors.primary_Color,
//       // bottomNavigationBar: BottomNavyBar(iconSize: 17,
//       // itemCornerRadius: 30,
//       //   backgroundColor: MyColors.primary_Color,
//       //   selectedIndex: _selectedIndex,
//       //   showElevation: true, // use this to remove appBar's elevation
//       //   onItemSelected: (index) => setState(() {
//       //     _selectedIndex = index;
//       //     // _pageController.animateToPage(index,
//       //     //     duration: Duration(milliseconds: 300), curve: Curves.ease);
//       //   }),
//       //   items: [
//       //     BottomNavyBarItem(
//       //       icon: Icon(FontAwesomeIcons.home),
//       //       title: Text('Home'),
//       //       activeColor: Colors.white,
//       //     ),
//       //     BottomNavyBarItem(
//       //         icon: Icon(FontAwesomeIcons.search),
//       //         title: Text('Search'),
//       //         activeColor: Colors.white),
//       //     BottomNavyBarItem(
//       //         icon: Icon(FontAwesomeIcons.dochub),
//       //         title: Text('Jobs'),
//       //         activeColor: Colors.white),
//       //     BottomNavyBarItem(
//       //         icon: Icon(FontAwesomeIcons.personBooth),
//       //         title: Text('Profile'),
//       //         activeColor: Colors.white),
//       //   ],
//       // )
//     );
//   }
// }


// // import 'package:flutter/material.dart';
