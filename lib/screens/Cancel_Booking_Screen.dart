import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/commons/colors.dart';
import 'package:tatkal_jobs_app/data/jobs.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/Job_Provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/screens/All_Jobs_Screen.dart';
import 'package:tatkal_jobs_app/widgets/cards/AllJobsCard.dart';
import 'package:tatkal_jobs_app/screens/old_ui/drawer.dart';
import 'package:timer_builder/timer_builder.dart';

import 'Job_Description_Screen.dart';

class CancelBooking extends StatelessWidget {
  static const routeName = '/CancelBooking';
  @override
  Widget build(BuildContext context) {
    var bookings = Provider.of<JobsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel Bookings"),
      ),
      body: FutureBuilder(
        future: bookings.fetchAppliedJobs(true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return CancelBookingBuilder();
          }
          return Container();
        },
      ),
    );
  }
}

class CancelBookingBuilder extends StatefulWidget {
  @override
  _AllJobsScreenBuilderState createState() => _AllJobsScreenBuilderState();
}

class _AllJobsScreenBuilderState extends State<CancelBookingBuilder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(
      builder: (context, prov, child) {
        final List<int> status = prov.status;
        return Column(
          children: [
            SizedBox(height: 15),
            prov.appliedjobs.length >= 1
                ? Expanded(
                    child: ListView.builder(
                      itemCount: prov.appliedjobs.length,
                      itemBuilder: (context, index) {
                        print("Jobs List2: ${prov.appliedjobs}");
                        return JobListWidget(
                            prov.appliedjobs[index], status[index]);
                        // prov.alljobs[index].jobName,
                        // prov.alljobs[index].companyName,
                        // prov.alljobs[index].jobDescription,
                        // prov.alljobs[index].companyAddress,
                        // prov.alljobs[index].qualification,
                        // index);
                      },
                    ),
                  )
                : Expanded(child: Center(child: Text("No Bookings"))),
          ],
        );
      },
    );
  }
}

class JobListWidget extends StatelessWidget {
  // String jobName;
  // String postedBy;
  // String jobDescription;
  // String jobLocation;
  // final int index;
  // String skills;
  final JobPost jobpost;
  int status;
  JobListWidget(this.jobpost, this.status);
  // JobListWidget(this.jobName, this.postedBy, this.jobDescription,
  //     this.jobLocation, this.skills, this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: CancelJobsCard(jobPost: jobpost, status: this.status),
      // jobName: jobName,
      // index: index,
      // jobDescription: jobDescription,
      // skills: skills,
      // jobLocation: jobLocation,
      // postedBy: postedBy),
    );
  }
}

class CancelJobsCard extends StatelessWidget {
  const CancelJobsCard(
      {Key? key,
      // required this.jobName,
      // required this.jobDescription,
      // required this.skills,
      // required this.jobLocation,
      // required this.postedBy,
      // required this.index,
      // this.listname = 'alljobs'
      required this.jobPost,
      required this.status})
      : super(key: key);

  // final String jobName;
  // final String jobDescription;
  // final String skills;
  // final String jobLocation;
  // final String postedBy;
  // final int index;
  // final String listname;
  final JobPost jobPost;
  final int status;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<JobsProvider>(context);
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobPost.jobName,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              jobPost.jobDescription,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, color: Colors.blue),
            ),
            SizedBox(height: 10),
            JobDescRows(FontAwesomeIcons.rupeeSign, jobPost.salary),
            JobDescRows(Icons.cases_sharp,
                DateFormat('dd-MM-yyyy').format(jobPost.workStart)),
            SizedBox(height: 5),
            JobDescRows(Icons.check, jobPost.qualification),
            SizedBox(height: 5),
            JobDescRows(Icons.location_on, jobPost.companyAddress),
            SizedBox(height: 5),
            JobDescRows(Icons.apartment, jobPost.companyName),
            SizedBox(height: 5),
            JobDescRows(Icons.apartment,
                "Applicants applied: " + jobPost.applicants.toString()),
            Row(
              children: [
                Spacer(),
                ShowTimer(jobPost.workStart),
                SizedBox(width: 5),
                Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: status == 0
                            ? Colors.red
                            : status == 1
                                ? Colors.green
                                : Colors.yellow,
                        borderRadius: BorderRadius.circular(5)),
                    child: status == 0
                        ? Text(
                            'Rejected',
                            style: TextStyle(color: Colors.white),
                          )
                        : status == 1
                            ? Text(
                                'Selected',
                                style: TextStyle(color: Colors.white),
                              )
                            : Text('Pending')),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor:
                          jobPost.workStart.difference(DateTime.now()) <
                                  Duration(hours: 8)
                              ? Colors.grey
                              : Colors.red,
                    ),
                    onPressed: () {
                      jobPost.workStart.difference(DateTime.now()) <
                              Duration(hours: 12)
                          ? AwesomeDialog(
                              context: context,
                              dialogType: DialogType.ERROR,
                              animType: AnimType.RIGHSLIDE,
                              title:
                                  'You can not cancel this post at this time',
                              btnOkColor: Colors.red,
                              btnOkOnPress: () {
                                // Navigator.pop(context);
                                return;
                              },
                            ).show()
                          : AwesomeDialog(
                              context: context,
                              dialogType: DialogType.WARNING,
                              animType: AnimType.BOTTOMSLIDE,
                              title: 'Cancel',
                              desc:
                                  'Are you sure you want to cancel this Job Application?',
                              // btnCancelOnPress: () {},
                              btnOkColor: Colors.red,
                              btnCancelOnPress: () {},
                              btnOkOnPress: () async {
                                print("uid: " +
                                    FirebaseAuth.instance.currentUser!.uid);
                                print("jid: " + jobPost.jobid);
                                await FirebaseFirestore.instance
                                    .collection('jobposts')
                                    .doc(jobPost.id)
                                    .update({
                                  "applicants": FieldValue.increment(-1)
                                });
                                prov.cncljobs(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    jobPost.jobid);
                              },
                            ).show();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Cancel'),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ShowTimer extends StatelessWidget {
  ShowTimer(this.workStart);
  final DateTime workStart;

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
      return workStart.isBefore(DateTime.now())
          ? Container()
          : Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.yellow, borderRadius: BorderRadius.circular(5)),
              child: Text(
                  "${workStart.difference(DateTime.now()).toString().substring(0, 8)}"));
    });
  }
}
