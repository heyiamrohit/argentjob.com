import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/Job_Provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/screens/alert_dialog.dart';
import 'package:video_player/video_player.dart';

class JobDetailNoApplyWidget extends StatefulWidget {
  static const routeName = '/JobDetailWidgetWithoutApply';
  final JobPost jobpost;
  JobDetailNoApplyWidget(this.jobpost);

  @override
  _JobDetailWidgetState createState() => _JobDetailWidgetState(this.jobpost);
}

class _JobDetailWidgetState extends State<JobDetailNoApplyWidget> {
  final _formkey = GlobalKey<FormState>();
  final JobPost jobPost;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  _JobDetailWidgetState(this.jobPost);
  @override
  Widget build(BuildContext context) {
    // VideoPlayerController? controller;
    // controller = VideoPlayerController.network(jobPost.jobVid);
    // controller.initialize();
    // controller.setLooping(true);
    // controller.setVolume(2.0);
    // controller.play();
    final prov = Provider.of<AuthProvider>(context);
    final jobprovider = Provider.of<JobsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(jobPost.jobName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      'Company Name',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      jobPost.companyName,
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                ],
                              )),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    'Job Name',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    jobPost.jobName,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black26,
                                ),
                              ],
                            )),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: jobPost.jobid));
                            final snackBar = SnackBar(
                              duration: Duration(seconds: 2),
                              content: const Text('Job id copied to clipboard'),
                              backgroundColor: (Colors.black),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.copy_all),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  labelText: "Job Id",
                                ),
                                initialValue:
                                    jobPost.jobid.substring(0, 10) + "...",
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: jobPost.userId));
                            final snackBar = SnackBar(
                              duration: Duration(seconds: 2),
                              content:
                                  const Text('User id copied to clipboard'),
                              backgroundColor: (Colors.black),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                enabled: false,
                                // maxLength: 10,
                                decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.copy_all),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  labelText: "User Id",
                                ),
                                initialValue:
                                    jobPost.userId.substring(0, 10) + "...",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Place Image',
                          style: TextStyle(fontSize: 17),
                        )),
                    AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Image.network(
                          jobPost.jobImg,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Job Description/ work details',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    jobPost.jobDescription,
                  ),
                ),
                Divider(
                  color: Colors.black26,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Company Address',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    jobPost.companyAddress,
                  ),
                ),
                Divider(
                  color: Colors.black26,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Qualification Required',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    jobPost.qualification,
                  ),
                ),
                Divider(
                  color: Colors.black26,
                ),
                jobPost.interviewData.length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Interview Data',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              jobPost.interviewAdditional,
                            ),
                          ),
                          Divider(
                            color: Colors.black26,
                          ),
                        ],
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Experience Required/ Worker Details',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    jobPost.experience,
                  ),
                ),
                Divider(
                  color: Colors.black26,
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
                          labelText: jobPost.interviewData.length > 0
                              ? 'Interview Start Date'
                              : 'Work Start Date'),
                      initialValue:
                          format.format(jobPost.workStart)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.43,
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
                            labelText: 'Male Seat'),
                        keyboardType: TextInputType.number,
                        initialValue: jobPost.maleSeat,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.43,
                      child: TextFormField(
                        initialValue: jobPost.femaleSeat,
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
                            labelText: 'Female Seat'),
                        // onTap: () {},
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
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
                        labelText: jobPost.interviewData.length >= 1
                            ? 'Working hours/day'
                            : 'Working days'),
                    initialValue: jobPost.workingDays,
                    // onTap: () {},
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: jobPost.salary.toString(),
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
                        labelText: 'Salary/per day'),
                    // onTap: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Per Day Amount'),
                                Spacer(),
                                Checkbox(
                                    value: jobPost.perDayAmount,
                                    onChanged: (_) {}),
                              ],
                            ),
                            jobPost.interviewData.length > 0
                                ? Row(
                                    children: [
                                      Text('Monthly Pay'),
                                      Spacer(),
                                      Checkbox(
                                          value: jobPost.monthlyAmount,
                                          onChanged: (_) {}),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Room Facility',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Spacer(),
                                Checkbox(
                                    value: jobPost.roomFacility,
                                    onChanged: (val) {}),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Food Facility'),
                                Spacer(),
                                Checkbox(
                                    value: jobPost.foodFacility,
                                    onChanged: (val) {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Payment Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 25)),
                          ),
                        ],
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
                              labelText: 'Name'),
                          initialValue: jobPost.jobName,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Position',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          jobPost.paymentPosition,
                        ),
                      ),
                      Divider(
                        color: Colors.black26,
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
                              labelText: 'Payment Date and Time'),
                          initialValue: format.format(jobPost.paymentDate),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
