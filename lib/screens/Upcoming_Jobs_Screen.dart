import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/data/jobs.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/Job_Provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/screens/lottieScreens/loginerror.dart';
import 'package:tatkal_jobs_app/widgets/cards/AllJobsCard.dart';

class UpcomingJobs extends StatelessWidget {
  static const routeName = '/upcoming-jobs';
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<JobsProvider>(context);
    final authprov = Provider.of<AuthProvider>(context, listen: false);
    return authprov.isAuthenticated
// true
        ? FutureBuilder(
            future: prov.fetchUpcomingJobs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return UpcomingJobsBuilder();
              }
              return Container();
            },
          )
        : LoginError();
  }
}

class UpcomingJobsBuilder extends StatefulWidget {
  @override
  _AllJobsScreenBuilderState createState() => _AllJobsScreenBuilderState();
}

class _AllJobsScreenBuilderState extends State<UpcomingJobsBuilder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsProvider>(
      builder: (context, prov, child) {
        return prov.upcomingjobs.length > 0
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: prov.upcomingjobs.length,
                      itemBuilder: (context, index) {
                        print("Jobs List2: ${prov.upcomingjobs}");
                        return JobListWidget(prov.upcomingjobs[index]);
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Text('No Upcoming Jobs'),
              );
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
