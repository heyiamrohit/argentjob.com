import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
// import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/providers/notification.dart';
import 'package:tatkal_jobs_app/screens/Last_Applied_Screen.dart';
import 'package:tatkal_jobs_app/screens/List_of_Applicants_Screen.dart';
import 'package:tatkal_jobs_app/screens/Post_Job_Screen.dart';
import 'package:tatkal_jobs_app/screens/All_Jobs_Screen.dart';
import 'package:tatkal_jobs_app/screens/Black_List_Screen.dart';
// import 'package:tatkal_jobs_app/screens/Post_Job_Screen.dart';
import 'package:tatkal_jobs_app/screens/Sign_Up_Screen_AfterOtp.dart';
import 'package:tatkal_jobs_app/screens/complain_box.dart';
import 'package:tatkal_jobs_app/screens/Home_Screen.dart';

import 'package:tatkal_jobs_app/screens/Job_Description_Screen.dart';
import 'package:tatkal_jobs_app/screens/Post_Interview_Screen.dart';
import 'package:tatkal_jobs_app/screens/My_Jobs_Screen.dart';
import 'package:tatkal_jobs_app/screens/Notification_Screen.dart';
// import 'package:tatkal_jobs_app/screens/old_ui/poster_profile.dart';
import 'package:tatkal_jobs_app/screens/Profile_screen.dart';
import 'package:tatkal_jobs_app/screens/Terms_Condition_Screen.dart';
import 'package:tatkal_jobs_app/screens/sharedPrefrences/imagePicker.dart';
import 'package:tatkal_jobs_app/screens/sharedPrefrences/sharedPrfrnces.dart';
// import 'package:tatkal_jobs_app/screens/network_error_screen.dart';
import 'providers/Job_Provider.dart';
import 'providers/black_list.dart';
import 'providers/otpProvider.dart';
import 'screens/Cancel_Booking_Screen.dart';
import 'screens/JobDesc_WithouApply.dart';
import 'screens/Login_Screen.dart';
import 'screens/SignUp_Screen.dart';
import 'screens/Upcoming_Jobs_Screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'screens/phone_auth_screen.dart';
import 'screens/sharedPrefrences/videoPicker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool is_netowrk_connected = false;

  /*
  
  
   
  --------------------------- network ---------------------------------------------------- */

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      //  Provider.of<AuthProvider>(context).isAuthenticated = Provider.of<ShardPrfnc>(context, listen: false).getBoolValuesSF('isauthenticated');
      //  print(Provider.of<AuthProvider>(context).isAuthenticated);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
  /*--------------------------- connectivity + ---------------------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlackListProvider>(
          create: (_) => BlackListProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<OtpProvider>(
          create: (_) => OtpProvider(),
        ),
        ChangeNotifierProvider<NotificationProvider>(
          create: (_) => NotificationProvider(),
        ),
        ChangeNotifierProvider<JobsProvider>(
          create: (_) => JobsProvider(),
        ),
        ChangeNotifierProvider<ShardPrfnc>(
          create: (_) => ShardPrfnc(),
        )
      ],
      child: MaterialApp(
        title: 'Job Portal',
        // theme: ThemeData(),
        theme: ThemeData(
            // primaryColor: MyColors.primary_Color,
            ),

        // home: _connectionStatus == ConnectivityResult.none
        //     ? NetworkError()
        // : IntroScreen(),

        // home: Text(_connectionStatus.toString()),
        // home: VideoPkr(),
        home: IntroScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          SignUpOtp.routeName: (ctx) => SignUpOtp(''),
          SignUpScreen.routeName: (ctx) => SignUpScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          UpcomingJobs.routeName: (ctx) => UpcomingJobs(),
          LastApplied.routeName: (ctx) => LastApplied(),
          AllJobs.routeName: (ctx) => AllJobs(),
          PostJob.routeName: (ctx) => PostJob(),
          PostInterview.routeName: (ctx) => PostInterview(),
          CancelBooking.routeName: (ctx) => CancelBooking(),
          MyJobscreen.routeName: (ctx) => MyJobscreen(),
          BlackListScreen.routeName: (ctx) => BlackListScreen(),
          ComplainBox.routeName: (ctx) => ComplainBox(),
          Terms_And_Condition.routeName: (ctx) => Terms_And_Condition(),
          NotificatonScreen.routeName: (ctx) => NotificatonScreen(),
          IntroScreen.routeName: (ctx) => IntroScreen(),
          ListOfApplicantsScreen.routeName: (ctx) => ListOfApplicantsScreen(''),
          //Job Detail Screen
          //JobDetailWidget.routeName: (ctx) => JobDetailWidget(Provider.of<JobsProvider>(context).alljobs[0]),
          // MyJobscreen.routeName: (ctx) => MyJobscreen(),
          // JobPosted.routeName: (ctx) => JobPosted(),
          //Bottom Navbar screens
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
        },
      ),
    );
  }
}
