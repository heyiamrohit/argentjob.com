import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/commons/colors.dart';
import 'package:tatkal_jobs_app/data/jobs.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/Job_Provider.dart';
import 'package:tatkal_jobs_app/screens/List_of_Applicants_Screen.dart';
// import 'package:tatkal_jobs_app/widgets/JobDescriptonRows.dart';
import 'package:tatkal_jobs_app/widgets/cards/AllJobsCard.dart';
import 'package:timer_builder/timer_builder.dart';

import 'Job_Description_Screen.dart';

class MyJobscreen extends StatelessWidget {
  static const routeName = '/MyJobscreen';
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<JobsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Jobs"),
      ),
      body: FutureBuilder(
        future: prov.fetchMyJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error'));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MyJobsScreenBuilder();
          }
          return Container();
        },
      ),
    );
  }
}

class MyJobsScreenBuilder extends StatefulWidget {
  @override
  _AllJobsScreenBuilderState createState() => _AllJobsScreenBuilderState();
}

class _AllJobsScreenBuilderState extends State<MyJobsScreenBuilder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(
      builder: (context, prov, child) {
        return prov.myjobs.length >= 1
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: prov.myjobs.length,
                      itemBuilder: (context, index) {
                        print("Jobs List2: ${prov.myjobs}");
                        return JobListWidget(prov.myjobs[index]);
                      },
                    ),
                  ),
                ],
              )
            : Center(child: Text('No Posted Jobs'));
      },
    );
  }
}

class JobListWidget extends StatelessWidget {
  final JobPost jobpost;
  JobListWidget(this.jobpost);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: AllJobsCard(jobPost: jobpost),
    );
  }
}

class AllJobsCard extends StatelessWidget {
  const AllJobsCard({Key? key, required this.jobPost}) : super(key: key);

  final JobPost jobPost;
  // bool redirect = false;
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
            SizedBox(height: 5),
            // JobDescRows(Icons.cases_sharp, 'Starting on 20/08/2021'),
            JobDescRows(Icons.cases_sharp,
                DateFormat('dd-MM-yyyy').format(jobPost.workStart)),
            SizedBox(height: 5),
            JobDescRows(
                Icons.check,
                jobPost.qualification.substring(
                    0,
                    jobPost.qualification.length > 50
                        ? 50
                        : jobPost.qualification.length)),
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
                ShowTimer(jobPost.workStart.subtract(Duration(hours: 8))),
                SizedBox(width: 5),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: MyColors.primary_Color),
                    onPressed: () {
                      print("*******" + jobPost.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ListOfApplicantsScreen(jobPost.id)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Applicants'),
                    )),
                SizedBox(width: 5),
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: jobPost.isActive
                          ? Colors.green
                          : jobPost.workStart.difference(DateTime.now()) <
                                  Duration(hours: 8)
                              ? Colors.grey
                              : Colors.red,
                    ),
                    onPressed: () async {
                      if (!(jobPost.isActive) &&
                          (jobPost.workStart.difference(DateTime.now()) <
                              Duration(hours: 8))) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          animType: AnimType.RIGHSLIDE,
                          title: 'You can not disable this post',
                          btnOkColor: Colors.red,
                          btnOkOnPress: () {
                            return;
                          },
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.QUESTION,
                          animType: AnimType.BOTTOMSLIDE,
                          title: 'Are you Sure?',
                          btnCancelOnPress: () {},
                          btnOkColor: MyColors.primary_Color,
                          btnOkOnPress: () {
                            prov.updateJob(jobPost.id, !jobPost.isActive);
                          },
                        )..show();
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: jobPost.isActive
                            ? Text('Active')
                            : Text('Inactive'))),
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