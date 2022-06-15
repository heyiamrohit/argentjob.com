import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/data/jobs.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/providers/Job_Provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:tatkal_jobs_app/widgets/cards/AllJobsCard.dart';
import 'package:tatkal_jobs_app/widgets/cards/AllJobsNoApplyCard.dart';

late List<JobPost> jobs;

class AllJobs extends StatefulWidget {
  static const routeName = '/alljobs';

  @override
  _AllJobsState createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<JobsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("All Jobs"),
          elevation: 1,
        ),
        body: FutureBuilder(
          future: prov.fetchJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              jobs = prov.alljobs;
              return AllJobsScreenBuilder();
            }
            return Container();
          },
        ));
  }
}

class AllJobsScreenBuilder extends StatefulWidget {
  @override
  _AllJobsScreenBuilderState createState() => _AllJobsScreenBuilderState();
}

class _AllJobsScreenBuilderState extends State<AllJobsScreenBuilder> {
  int current = 0;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<JobsProvider>(context);
    return Column(
      children: [
        SizedBox(height: 15),
        Wrap(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: TextFormField(
                onChanged: (value) {
                  print(value);
                  setState(() {
                    if (current == 0)
                      jobs = prov.alljobs;
                    else if (current == 1)
                      jobs = prov.onlyInterview;
                    else
                      jobs = prov.onlyJob;
                    jobs = jobs
                        .where((element) =>
                            element.jobName
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.jobDescription
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.companyName
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.companyAddress
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.experience
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.jobid
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            element.salary
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                    print(jobs);
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixStyle: TextStyle(color: Colors.red),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                height: 50,
                child: jobs.length != prov.alljobs.length
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            jobs = prov.alljobs;
                          });
                        },
                        icon: Icon(Icons.close))
                    : IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: const Text('Filter:'),
                                children: <Widget>[
                                  SimpleDialogOption(
                                    onPressed: () {
                                      setState(() {
                                        jobs = prov.onlyJob;
                                        current = -1;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Direct jobs"),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      setState(() {
                                        jobs = prov.onlyInterview;
                                        current = 1;
                                      });
                                      Navigator.of(context).pop();
                                      print("CUREENT: " + current.toString());
                                    },
                                    child: const Text('Interview jobs'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.arrow_drop_down)))
          ],
        ),
        Expanded(
          child: jobs.length > 0
              ? ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    return JobListWidget(jobs[index]);
                  },
                )
              : Center(child: Text("No Jobs Available")),
        ),
      ],
    );
  }
}

class JobListWidget extends StatelessWidget {
  final JobPost jobpost;
  JobListWidget(this.jobpost);
  @override
  Widget build(BuildContext context) {
    final authprov = Provider.of<AuthProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: authprov.isAuthenticated
          ? AllJobsCard(jobPost: jobpost)
          : AllJobsNoApplyCard(jobPost: jobpost),
    );
  }
}
