import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/screens/sharedPrefrences/sharedPrfrnces.dart';
import 'Black_List_Screen.dart';
import 'Last_Applied_Screen.dart';
import 'Login_Screen.dart';
import 'Post_Job_Screen.dart';
import 'Upcoming_Jobs_Screen.dart';
import 'My_Jobs_Screen.dart';
import 'Notification_Screen.dart';
import 'Terms_Condition_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'All_Jobs_Screen.dart';
import 'Cancel_Booking_Screen.dart';
import 'Profile_screen.dart';
import 'Post_Interview_Screen.dart';
import 'SignUp_Screen.dart';
import 'complain_box.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/Introscreen';
  @override
  State<StatefulWidget> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late String title;
  Color colors = Colors.black;
  // ignore: unused_field
  static const routeName = '/home';
  bool isauthenticated = false;

  Future init() async {
    isauthenticated = await Provider.of<ShardPrfnc>(context)
            .getBoolValuesSF('isauthenticated') ??
        false;
    print("INITSTTAE ISAUTH" + isauthenticated.toString());
    // final bool authprov = Provider.of<ShardPrfnc>(context, listen: false)
    //     .getBoolValuesSF('isauthenticated')??false;
    Provider.of<AuthProvider>(context, listen: false).isAuthenticated =
        isauthenticated;
  }

  @override
  Widget build(BuildContext context) {
    final otpprov = Provider.of<AuthProvider>(context, listen: false);

    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Lottie.asset('assets/lottie/letter.json'));
        } else if (snapshot.hasError) {
          print(snapshot.error);

          return Scaffold(body: Lottie.asset('assets/lottie/letter.json'));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print('ISAUTHTHTHTHHT:' + isauthenticated.toString());
          return DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('Argent Job'),
                actions: [
                  // is_authenticated
                  isauthenticated
                      // isauthenticated
                      ? InkWell(
                          onTap: () {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Logout',
                              desc: 'Are you Sure you want to Logout?',
                              // btnCancelOnPress: () {},
                              btnOkColor: Colors.red,
                              btnCancelColor: Colors.green,
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                otpprov.signOut().then((value) {
                                  Provider.of<ShardPrfnc>(context,
                                          listen: false)
                                      .addBoolToSF("isauthenticated", false);
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      IntroScreen.routeName, (route) => false);
                                });
                              },
                            )..show();
                          },
                          child: Chip(
                            label: Text('Log Out'),
                            // shadowColor: Colors.red,
                            // avatar: Icon(Icons.add),
                          ),
                        )
                      : Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                              child: Text('Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(SignUpScreen.routeName),
                              child: Chip(
                                label: Text('Sign up'),
                                // shadowColor: Colors.red,
                                // avatar: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),

                  SizedBox(width: 8),
                  //decoration: TextDecoration.underline,
                  //decorationStyle: TextDecorationStyle.solid,)
                ],
                bottom: TabBar(
                  unselectedLabelColor: Colors.white,
                  tabs: [
                    Tab(
                      text: 'DashBoard',
                    ),
                    Tab(
                      text: 'Upcoming Jobs',
                    ),
                    Tab(
                      text: 'Last Applied',
                    ),
                  ],
                ),
              ),
              body: HomePage(),
              bottomNavigationBar: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Container(
                    // color: Colors.black38,
                    // color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              // _selectedIndex = 0;
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.home,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  Text('Home',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 13)),
                                  //decoration: TextDecoration.underline,
                                  //decorationStyle: TextDecorationStyle.solid,
                                ],
                              ),
                              // width: 25,
                              height: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // _selectedIndex = 0;
                              isauthenticated
                                  ? Navigator.of(context).pushNamed(
                                      ProfileScreen.routeName,
                                      // arguments: product.id
                                    )
                                  // : alertDialogue(context);
                                  : AwesomeDialog(
                                      context: context,
                                      showCloseIcon: true,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.BOTTOMSLIDE,
                                      title: 'Please log in to continue',
                                      btnOkText: 'Login',
                                      btnOkColor:Colors.red,
                                      btnOkOnPress: () {
                                        Navigator.of(context).pushNamed(
                                          LoginScreen.routeName,
                                        );
                                      },
                                    ).show();
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                                  Text('My Account',
                                      style: TextStyle(fontSize: 13)),
                                  //decoration: TextDecoration.underline,
                                  //decorationStyle: TextDecorationStyle.solid,
                                ],
                              ),
                              // width: 25,
                              height: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              launch('https://argentjob.com');
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.launch,
                                    size: 20,
                                  ),
                                  Text('Website',
                                      style: TextStyle(fontSize: 13)),
                                  //decoration: TextDecoration.underline,
                                  //decorationStyle: TextDecorationStyle.solid,
                                ],
                              ),
                              // width: 25,
                              height: 40,
                            ),
                          ),
                        ])),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class HomePage extends StatelessWidget {
  bool isauthenticated = false;

  @override
  Widget build(BuildContext context) {
    Future init() async {
      isauthenticated = await Provider.of<ShardPrfnc>(context)
              .getBoolValuesSF('isauthenticated') ??
          false;
      print("INITSTTAE ISAUTH" + isauthenticated.toString());
    }

    final otpprov = Provider.of<AuthProvider>(context, listen: false);
    return FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print('ISAUTHTHTHTHHT:' + isauthenticated.toString());
            return TabBarView(children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.red,
                                ),

                                Text(
                                    '   500 fine for making fake post application',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(fontSize: 15)),
                                //decoration: TextDecoration.underline,
                                //decorationStyle: TextDecorationStyle.solid,
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: Colors.red,
                                ),
                                Text(
                                    '   500 fine for making fake apply application',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: GridView(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, AllJobs.routeName),
                                child: Icon_Widget(
                                    icons: Icons.cases_outlined,
                                    colors: Colors.purple,
                                    title: 'All Jobs'),
                              ),
                              InkWell(
                                onTap: () =>
                                    // true
                                    Provider.of<AuthProvider>(context,
                                                listen: false)
                                            .isAuthenticated
                                        ? Navigator.pushNamed(
                                            context, PostJob.routeName)
                                        : alertDialogue(context).show(),
                                child: Icon_Widget(
                                    icons: Icons.add_outlined,
                                    colors: Colors.green,
                                    title: 'Post Jobs'),
                              ),
                              InkWell(
                                onTap: () => Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .isAuthenticated
                                    ? Navigator.pushNamed(
                                        context, PostInterview.routeName)
                                    : alertDialogue(context).show(),
                                child: Icon_Widget(
                                    icons: Icons.add_box_outlined,
                                    colors: Colors.blue,
                                    title: 'Post Interview'),
                              ),
                              InkWell(
                                onTap: () {
                                  Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .isAuthenticated
                                      ? Navigator.of(context).pushNamed(
                                          CancelBooking.routeName,
                                          // arguments: product.id
                                        )
                                      : alertDialogue(context).show();
                                },
                                child: Icon_Widget(
                                    icons: Icons.cancel_outlined,
                                    colors: Colors.pink,
                                    title: 'Cancel Booking'),
                              ),
                              InkWell(
                                onTap: () => Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .isAuthenticated
                                    ? Navigator.pushNamed(
                                        context, MyJobscreen.routeName)
                                    : alertDialogue(context).show(),
                                child: Icon_Widget(
                                    icons: FontAwesomeIcons.suitcase,
                                    colors: Colors.red,
                                    title: 'My Jobs'),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, BlackListScreen.routeName),
                                child: Icon_Widget(
                                    icons: Icons.file_copy_sharp,
                                    colors: Colors.lightGreen,
                                    title: 'Black List'),
                              ),
                              InkWell(
                                onTap: () => Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .isAuthenticated
                                    ? Navigator.pushNamed(
                                        context, ComplainBox.routeName)
                                    : alertDialogue(context).show(),
                                child: Icon_Widget(
                                    icons: Icons.live_help_outlined,
                                    colors: Colors.lightGreen,
                                    title: 'Complain Box'),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, Terms_And_Condition.routeName),
                                child: Icon_Widget(
                                    icons: Icons.gavel,
                                    colors: Colors.blueAccent,
                                    title: 'Rules and Regulations'),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, NotificatonScreen.routeName),
                                child: Icon_Widget(
                                    icons: Icons.notifications,
                                    colors: Colors.pink,
                                    title: 'Notification'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              UpcomingJobs(),
              LastApplied()
            ]);
          } else {
            return Container();
          }
        });
  }

  AwesomeDialog alertDialogue(BuildContext context) {
    return AwesomeDialog(
      context: context,
      showCloseIcon: true,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Please log in to continue',
      btnOkText: 'Login',
      btnOkColor: Colors.red,
      btnOkOnPress: () {
        Navigator.of(context).pushNamed(
          LoginScreen.routeName,
        );
      },
    );
  }
}

class Icon_Widget extends StatelessWidget {
  const Icon_Widget({
    Key? key,
    required this.icons,
    required this.colors,
    required this.title,
  }) : super(key: key);

  final IconData icons;
  final Color colors;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 3,
          child: Container(
            //  color:  Colors.red,
            alignment: Alignment.center,
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(40),

              child: Container(
                child: Icon(
                  icons,
                  size: 40,
                  color: colors,
                ),
                height: 65,
                width: 50,

                // ),
              ),
            ),
          ),
        ),
        SizedBox(height: 7),
        Center(
          child: FittedBox(
            child: Text('$title',
                // overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 15)),
          ),
        ),
      ],
    );
  }
}
