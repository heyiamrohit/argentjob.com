import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tatkal_jobs_app/models/jobs.dart';
import 'package:tatkal_jobs_app/models/user_profile.dart';

class JobsProvider with ChangeNotifier {
  List<JobPost> alljobs = [];
  List<JobPost> upcomingjobs = [];
  List<JobPost> myjobs = [];
  List<UserModel> accapplicants = [];
  List<UserModel> rejapplicants = [];
  List<UserModel> penapplicants = [];

  Future fetchAccepted(String jobid) async {
    List<JobApplied> jobAppliedList = [];
    accapplicants.clear();
    QuerySnapshot acceptedData;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jobsapplied')
        .where('job_id', isEqualTo: jobid)
        .where('status', isEqualTo: 1)
        .get();
    jobAppliedList =
        querySnapshot.docs.map((doc) => JobApplied.fromDocument(doc)).toList();
    //print("len acc*********" + jobAppliedList.length.toString());
    try {
      //print("*****" + jobAppliedList[0].userId);
    } catch (e) {
      //print("*****" + e.toString());
    }
    for (var i = 0; i < jobAppliedList.length; i++) {
      acceptedData = await FirebaseFirestore.instance
          .collection("users")
          .where("user", isEqualTo: jobAppliedList[i].userId.toString())
          .get();
      //print("Accpdl:::" + acceptedData.docs.length.toString());
      for (var j = 0; j < acceptedData.docs.length; j++) {
        accapplicants.add(UserModel.fromDocument(acceptedData.docs[j]));
      }
      //print("Applied jobs len: " + accapplicants.length.toString());
      //print("Acc: " + accapplicants.length.toString());
    }
  }

  Future fetchRejected(String jobid) async {
    List<JobApplied> jobAppliedList = [];
    rejapplicants.clear();
    QuerySnapshot acceptedData;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jobsapplied')
        .where('job_id', isEqualTo: jobid)
        .where('status', isEqualTo: 0)
        .get();
    jobAppliedList =
        querySnapshot.docs.map((doc) => JobApplied.fromDocument(doc)).toList();
    //print("len rej*********" + jobAppliedList.length.toString());
    try {
      //print("*****" + jobAppliedList[0].userId);
    } catch (e) {
      //print("*****" + e.toString());
    }
    for (var i = 0; i < jobAppliedList.length; i++) {
      acceptedData = await FirebaseFirestore.instance
          .collection("users")
          .where("user", isEqualTo: jobAppliedList[i].userId.toString())
          .get();
      //print("Accpdl::" + acceptedData.docs[0].data().toString());

      for (var j = 0; j < acceptedData.docs.length; j++) {
        rejapplicants.add(UserModel.fromDocument(acceptedData.docs[j]));
      }
    }
    //print("Rej: " + rejapplicants.length.toString());
  }

  Future fetchPending(String jobid) async {
    List<JobApplied> jobAppliedList = [];
    penapplicants.clear();
    QuerySnapshot acceptedData;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jobsapplied')
        .where('job_id', isEqualTo: jobid)
        .where('status', isEqualTo: -1)
        .get();
    jobAppliedList =
        querySnapshot.docs.map((doc) => JobApplied.fromDocument(doc)).toList();
    //print("len*********" + jobAppliedList.length.toString());
    try {
      //print("*****" + jobAppliedList[0].userId);
    } catch (e) {
      //print("*****" + e.toString());
    }
    for (var i = 0; i < jobAppliedList.length; i++) {
      acceptedData = await FirebaseFirestore.instance
          .collection("users")
          .where("user", isEqualTo: jobAppliedList[i].userId.toString())
          .get();
      //print("Accpdl::::" + acceptedData.docs.length.toString());

      for (var j = 0; j < acceptedData.docs.length; j++) {
        penapplicants.add(UserModel.fromDocument(acceptedData.docs[j]));
      }
      //print("Pending Applicants len: " + penapplicants.length.toString());
    }
  }

  bool loading = true;
  // bool appliedAlready = false;

  List<JobPost> appliedjobs = [];
  List<int> status = [];
  // List<String> jobids = [];
  // we take user id -> get job id from jobsapplied collection and then use that job id to get a list of applied jobs
  Future fetchAppliedJobs(bool isCancel) async {
    List<JobApplied> appliedjobid = [];
    appliedjobs.clear();
    DocumentSnapshot appliedjobsdata;
    QuerySnapshot querySnapshot;
    if (isCancel) {
      querySnapshot = await FirebaseFirestore.instance
          .collection('jobsapplied')
          .where('user_id',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
          .where('status', isEqualTo: -1)
          .get();
    } else {
      querySnapshot = await FirebaseFirestore.instance
          .collection('jobsapplied')
          .where('user_id',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
          .get();
    }
    appliedjobid =
        querySnapshot.docs.map((doc) => JobApplied.fromDocument(doc)).toList();
    // jobid.map((e) => appliedjobsdata.add(FirebaseFirestore.instance.collection("jobposts").doc(e.jobId.toString()).get()));
    // appliedjobsdata.map((e) => appliedjobs.add(e));
    print("len*********" + appliedjobid.length.toString());
    status.clear();
    for (var i = 0; i < appliedjobid.length; i++) {
      appliedjobsdata = await FirebaseFirestore.instance
          .collection("jobposts")
          .doc(appliedjobid[i].jobId.toString())
          .get();
      status.add(appliedjobid[i].status);
      appliedjobs.add(JobPost.fromDocument(appliedjobsdata));
      print("Applied jobs len: " + appliedjobs.length.toString());
    }
  }

  Future fetchJobs() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jobposts')
        .where("is_active", isEqualTo: true)
        .where("work_start_date",isGreaterThan: DateTime.now())
        .get();
    alljobs.clear();
    onlyInterview.clear();
    onlyJob.clear();
    alljobs = querySnapshot.docs
        .map((doc) => JobPost.fromDocument(
              doc,
            ))
        .toList();
    for (var i = 0; i < alljobs.length; i++) {
      if (alljobs[i].interviewData.length != 0) {
        onlyInterview.add(alljobs[i]);
      } else {
        onlyJob.add(alljobs[i]);
      }
    }
    // print(alljobs);
  }

  late bool isPending;
  Future checkApplied(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jobsapplied')
        .where("user_id", isEqualTo: uid)
        .where("status", isNotEqualTo: 0)
        .get();

    List<JobApplied> jobAppliedList =
        querySnapshot.docs.map((doc) => JobApplied.fromDocument(doc)).toList();
    List<String> jobids = [];
    for (var i = 0; i < jobAppliedList.length; i++) {
      jobids.add(jobAppliedList[i].jobId.toString());
    }
    bool dateCheck = false;
    for (var i = 0; i < jobids.length; i++) {
      DocumentSnapshot profSnape = await FirebaseFirestore.instance
          .collection('jobposts')
          .doc(jobids[i])
          .get();
      final data = JobPost.fromDocument(profSnape);
      print(data.id);
      bool also =
          DateTime.now().difference(data.workStart) < Duration(hours: 2);
      print("ALSOOOOOOOOOOOOOO"+also.toString());
      if (also) {
        dateCheck = true;
      }
    }
    // DocumentSnapshot profSnape = await FirebaseFirestore.instance
    //     .collection('jobposts')
    //     .doc(jobid)
    //     .get();
    // final data = JobPost.fromDocument(profSnape);
    // bool also = DateTime.now().difference(data.workStart) < Duration(hours: 2);

    isPending = querySnapshot.docs.length > 0 && dateCheck; // print(alljobs);
  }

  List<JobPost> onlyJob = [];
  List<JobPost> onlyInterview = [];

  Future cncljobs(String userid, String jobid) async {
    print("Cancelling: " + jobid.toString() + "**** uid: " + userid.toString());
    var querySnapshot = await FirebaseFirestore.instance
        .collection('jobsapplied')
        .where('user_id', isEqualTo: userid)
        .where('job_id', isEqualTo: jobid)
        .get();

    print(querySnapshot.docs.length.toString());
    print(querySnapshot.docs.toString());
    querySnapshot.docs.forEach((doc) => doc.reference.delete());
    print("Cancelled");
    notifyListeners();
  }

  // Future<void> alreadyApplied(String userid, String jobid) async {
  //   var querySnapshot = await FirebaseFirestore.instance
  //       .collection('jobsapplied')
  //       .where('user_id', isEqualTo: userid)
  //       .where('job_id', isEqualTo: jobid)
  //       .get();

  //   appliedAlready = querySnapshot.docs.length >= 1;
  // }

  Future fetchUpcomingJobs() async {
    Timestamp startDate = Timestamp.fromDate(DateTime.parse(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
        .toIso8601String()));
    var start = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jobposts')
        // .where("is_active", isEqualTo: true)
        .where("work_start_date", isGreaterThan: DateTime.now(), isLessThan: DateTime.now().add(Duration(days: 7)))
        .get();

    upcomingjobs = querySnapshot.docs
        .map((doc) => JobPost.fromDocument(
              doc,
            ))
        .toList();
  }

  Future fetchMyJobs() async {
    print("*******************" +
        FirebaseAuth.instance.currentUser!.uid.toString());
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('jobposts')
        .where('user_id',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    print("*************" + querySnapshot.docs.toString().length.toString());
    // print("*************" + querySnapshot.docs[0]['job_name'].toString());
    myjobs.clear();
    myjobs = querySnapshot.docs
        .map((doc) => JobPost.fromDocument(
              doc,
            ))
        .toList();
  }

  Future updateJob(String id, bool val) async {
    print("**********" + id);
    CollectionReference querySnapshot =
        await FirebaseFirestore.instance.collection('jobposts');
    querySnapshot.doc(id).update({'is_active': val});

    notifyListeners();
  }

  Future changeStatus(String id, int val, String jobid) async {
    print("USERID**********" + id);
    print("JOBID*******" + jobid);
    var querySnapshot = await FirebaseFirestore.instance
        .collection('jobsapplied')
        .where('user_id', isEqualTo: id)
        .where('job_id', isEqualTo: jobid)
        .get();
    querySnapshot.docs.forEach((e) => FirebaseFirestore.instance
        .collection('jobsapplied')
        .doc(e.id)
        .update({'status': val}));
    notifyListeners();
  }
}
