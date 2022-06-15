import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/data/jobs.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/Job_Provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/screens/lottieScreens/loginerror.dart';
import 'package:tatkal_jobs_app/widgets/cards/AllJobsCard.dart';
import 'package:tatkal_jobs_app/widgets/cards/AllJobsNoApplyCard.dart';

import 'Job_Description_Screen.dart';

class LastApplied extends StatefulWidget {
  static const routeName = '/last-applied';

  @override
  _LastAppliedState createState() => _LastAppliedState();
}

class _LastAppliedState extends State<LastApplied> {
  @override
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<JobsProvider>(context);
    final authprov = Provider.of<AuthProvider>(context);
    return authprov.isAuthenticated
        ? FutureBuilder(
            future: prov.fetchAppliedJobs(false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return prov.appliedjobs.length >= 1
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: prov.appliedjobs.length,
                              itemBuilder: (context, index) {
                                print("Jobs List2: ${prov.appliedjobs}");
                                return JobListWidget(prov.appliedjobs[index],
                                    prov.status[index]);
                              },
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text('You Haven\'t Applied to any Jobs Yet'),
                      );
              }
              return Container();
            },
          )
        : LoginError();
  }
}

class JobListWidget extends StatelessWidget {
  final JobPost jobpost;
  final int status;
  JobListWidget(this.jobpost, this.status);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: LastAppliedJobCard(jobPost: jobpost, status: status),
    );
  }
}

class LastAppliedJobCard extends StatelessWidget {
  const LastAppliedJobCard(
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
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => JobDetailWidget(
                                jobPost: jobPost,
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('View More'),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class JobDescRows extends StatelessWidget {
  final IconData icon;
  final String postedBy;
  JobDescRows(this.icon, this.postedBy);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
        ),
        SizedBox(width: 5),
        Text(
          postedBy,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
