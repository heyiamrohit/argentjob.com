import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/commons/colors.dart';
import 'package:tatkal_jobs_app/models/user_profile.dart';
import 'package:tatkal_jobs_app/providers/Job_Provider.dart';
import 'package:tatkal_jobs_app/screens/Profile_JobAppl_Screen.dart';

class ListOfApplicantsScreen extends StatefulWidget {
  final String jobId;
  ListOfApplicantsScreen(this.jobId);
  static const routeName = '/listofappl';
  @override
  _ListOfApplicantsScreenState createState() => _ListOfApplicantsScreenState();
}

class _ListOfApplicantsScreenState extends State<ListOfApplicantsScreen> {
  @override
  Widget build(BuildContext context) {
    print("------" + widget.jobId);
    final prov = Provider.of<JobsProvider>(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('List of Applicants'),
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.check_box),
                text: 'Accepted',
              ),
              Tab(
                icon: Icon(Icons.close),
                text: 'Rejected',
              ),
              Tab(
                icon: Icon(Icons.lock_clock),
                text: 'Pending',
              ),
            ],
          ),
        ),
        // backgroundColor: Colors.black87,
        body: TabBarView(
          children: [
            FutureBuilder(
              future: prov.fetchAccepted(widget.jobId),
              builder: (context, snapshot) {
                //print("JOB ID ---------" + widget.jobId);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return prov.accapplicants.length >= 1
                      ? ListView.builder(
                          itemCount: prov.accapplicants.length,
                          itemBuilder: (context, index) {
                            print("Jobs List2: ${prov.accapplicants}");
                            return UserList(
                                prov.accapplicants[index], false, widget.jobId);
                          })
                      : Center(
                          child: Text('No Applicants'),
                        );
                }
                return Container();
              },
            ),
            FutureBuilder(
              future: prov.fetchRejected(widget.jobId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  print("JOB ID ---------" + widget.jobId);
                  return prov.rejapplicants.length > 0
                      ? ListView.builder(
                          itemCount: prov.rejapplicants.length,
                          itemBuilder: (context, index) {
                            print("JOB ID ---------" + widget.jobId);
                            print("Jobs List2: ${prov.rejapplicants}");
                            return UserList(
                                prov.rejapplicants[index], false, widget.jobId);
                          })
                      : Center(
                          child: Text('No Applicants'),
                        );
                }
                return Container();
              },
            ),
            FutureBuilder(
              future: prov.fetchPending(widget.jobId),
              builder: (context, snapshot) {
                print("JOB ID ---------" + widget.jobId);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return prov.penapplicants.length >= 1
                      ? ListView.builder(
                          itemCount: prov.penapplicants.length,
                          itemBuilder: (context, index) {
                            print("Jobs List2: ${prov.penapplicants}");
                            return UserList(
                                prov.penapplicants[index], true, widget.jobId);
                          })
                      : Center(
                          child: Text('No Applicants'),
                        );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  final UserModel user;
  final bool isPending;
  final String jobId;
  UserList(this.user, this.isPending, this.jobId);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: UserListCards(userData: user, isPending: isPending, jobId: jobId),
    );
  }
}

class UserListCards extends StatelessWidget {
  const UserListCards(
      {Key? key,
      required this.userData,
      required this.isPending,
      required this.jobId})
      : super(key: key);

  final UserModel userData;
  final bool isPending;
  final String jobId;

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
              userData.name,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              userData.address,overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              userData.contactNum,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Spacer(),
                isPending
                    ? TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Are you Sure?',
                            desc: 'Do you want to select this Candidate?',
                            btnCancelOnPress: () {},
                            btnOkColor: Colors.green,
                            btnOkOnPress: () {
                              prov.changeStatus(userData.userId, 1, jobId);
                            },
                          )..show();
                        },
                        child: Text('Select'))
                    : Container(),
                SizedBox(
                  width: 5,
                ),
                isPending
                    ? TextButton(
                        style: TextButton.styleFrom(
                            primary: Colors.white, backgroundColor: Colors.red),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.BOTTOMSLIDE,
                            title: 'Are you Sure?',
                            desc: 'Do you want to reject this Candidate?',
                            btnCancelOnPress: () {},
                            btnOkColor: Colors.red,
                            btnOkOnPress: () {
                              prov.changeStatus(userData.userId, 0, jobId);
                            },
                          )..show();
                        },
                        child: Text('Reject'))
                    : Container(),
                    SizedBox(width: 5,),
                TextButton(
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: MyColors.primary_Color),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplicantProfile(userData)),
                      );
                    },
                    child: Text('View Profile'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
