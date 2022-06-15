import 'package:cloud_firestore/cloud_firestore.dart';

class JobPost {
  late String id;
  late String companyAddress;
  late String companyName;
  late String experience;
  // late bool extraForm;
  late String femaleSeat;
  late bool foodFacility;
  late String jobDescription;
  late String jobName;
  late String maleSeat;
  late String workingDays;
  late String paymentName;
  late String paymentPosition;
  late bool perDayAmount;
  late String qualification;
  late bool roomFacility;
  late bool monthlyAmount;
  late String userId;
  late DateTime paymentDate;
  late DateTime workStart;
  late String jobid;
  late bool isActive;
  late String salary;
  late int applicants;
  late String jobImg;
  // late String jobVid;
  late String interviewAdditional;

  //Interview
  late Map<String, dynamic> interviewData;

  JobPost.fromDocument(DocumentSnapshot document) {
    this.id = document.id;
    this.companyAddress = document['company_address'];
    this.jobImg = document['work_image'];
    // this.jobVid = document['work_video'];
    this.companyName = document['company_name'];
    this.experience = document['experience'];
    this.applicants = document['applicants'];
    // this.extraForm = document['extra_form'];
    this.interviewData = document['interview'];
    if(this.interviewData.length != 0){
      this.monthlyAmount = document['interview']['monthly_amount'];
    }
    if(this.interviewData.length != 0){
      this.interviewAdditional = document['interview']['interview_desc'];
    }
    this.jobid = document.id;
    this.salary = document['salary'];
    this.femaleSeat = document['female_seat'];
    this.foodFacility = document['food_facility'];
    this.jobDescription = document['job_description'];
    this.jobName = document['job_name'];
    this.maleSeat = document['male_seat'];
    this.workingDays = document['working_days'];
    this.paymentName = document['payment_name'];
    this.paymentPosition = document['payment_position'];
    this.perDayAmount = document['per_day_amount'];
    this.qualification = document['qualification'];
    this.roomFacility = document['room_facility'];
    this.userId = document['user_id'];
    this.isActive = document['is_active'];
    Timestamp workdate = document['work_start_date'];
    this.workStart = workdate.toDate();
    Timestamp paydate = document['payment_date'];
    this.paymentDate = paydate.toDate();
  }
}

class JobApplied {
  late String id;
  late String userId;
  late String jobId;
  late int status;
  JobApplied.fromDocument(DocumentSnapshot document) {
    this.id = document.id;
    this.userId = document['user_id'];
    this.jobId = document['job_id'];
    this.status = document['status'];
  }
}
