import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/screens/Job_Description_Screen.dart';

class AllJobsCard extends StatelessWidget {
  const AllJobsCard({Key? key, required this.jobPost}) : super(key: key);

  final JobPost jobPost;

  @override
  Widget build(BuildContext context) {
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

class JobsAppliedCard extends StatelessWidget {
  const JobsAppliedCard(
      {Key? key,
      required this.jobName,
      required this.jobDescription,
      required this.skills,
      required this.jobLocation,
      required this.postedBy,
      required this.index,
      required this.applicants,
      required this.workStart})
      : super(key: key);

  final String jobName;
  final String jobDescription;
  final List<String> skills;
  final String jobLocation;
  final DateTime workStart;
  final String postedBy;
  final int index;
  final int applicants;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobName,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 5),
            Text(
              jobDescription,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 17, color: Colors.blue),
            ),
            SizedBox(height: 10),
            JobDescRows(FontAwesomeIcons.rupeeSign, '200 / day'),
            JobDescRows(
                Icons.cases_sharp, DateFormat('dd-MM-yyyy').format(workStart)),
            SizedBox(height: 5),
            JobDescRows(
              Icons.check,
              skills.join(","),
            ),
            SizedBox(height: 5),
            JobDescRows(Icons.location_on, jobLocation),
            SizedBox(height: 5),
            JobDescRows(Icons.apartment, postedBy),
            SizedBox(height: 5),
            JobDescRows(Icons.apartment, postedBy),
            SizedBox(height: 5),
            JobDescRows(Icons.apartment,
                "Applicants applied: " + applicants.toString()),
            Row(
              children: [
                Spacer(),
                TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
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
          postedBy.length > 40 ? postedBy.substring(0,40)+'..' : postedBy,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
