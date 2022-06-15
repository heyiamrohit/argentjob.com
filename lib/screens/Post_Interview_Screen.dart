import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tatkal_jobs_app/providers/auth.dart';
import 'package:video_player/video_player.dart';

import 'Home_Screen.dart';
import 'sharedPrefrences/imagePicker.dart';
import 'sharedPrefrences/videoPicker.dart';

class PostInterview extends StatefulWidget {
  static const routeName = '/post-interview';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PostInterview> {
  bool isloading = false;
  final companynameController = TextEditingController();
  final jobNameController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final companyAddressController = TextEditingController();
  final qualificationController = TextEditingController();
  final experienceController = TextEditingController();
  final interviewDescriptionController = TextEditingController();

  bool extraformController = false;
  bool workingdaysController = true;
  bool monthlypayController = true;

  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime workstartdate = DateTime.now();
  DateTime workoffdate = DateTime.now();
  DateTime paymentdatetime = DateTime.now();
  // final workdateController = TextEditingController();
  bool roomfacilityController = false;
  bool perdayamountController = false;
  bool foodController = false;
  // final workstartController = TextEditingController();
  // final workoffController = TextEditingController();
  final paymentNameController = TextEditingController();
  final paymentPositionController = TextEditingController();
  // final paymentDateController = TextEditingController();
  // final paymentTimeController = TextEditingController();
  // DateTime paymentTimeController = DateTime.now();
  /*--------------------------- My Changes ---------------------------------------------------- */
  final maleSeatController = TextEditingController();
  final femaleSeatController = TextEditingController();
  final workingDaysController = TextEditingController();
  final salaryController = TextEditingController();
  bool isEnabled = true;

  Future PostJob(String collectionName, Map<String, dynamic> data) async {
    // await
    setState(() {
      isloading = true;
    });
    try {
      if (_formkey.currentState!.validate()) {
        print('validate done');
        await FirebaseFirestore.instance
            .collection(collectionName)
            .add(data)
            .then((value) {
          setState(() {
            isloading = false;
          });
          Navigator.of(context).pushNamed(IntroScreen.routeName);

          final snackBar = SnackBar(
            content: const Text('Interview Added'),
            // backgroundColor: (Colors.black12),
            // action: SnackBarAction(
            //   label: 'Ok',
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            setState(() {
              isloading = false;
            });
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  String videoUrl = 'https://picsum.photos/200';
  String imageUrl = 'https://picsum.photos/200';
  VideoPlayerController? controller;

  getImagelink(String imgUrl) {
    log("Here is image url: $imgUrl");
    setState(() {
      imageUrl = imgUrl;
    });
  }

  getVideolink(String vidUrl) {
    setState(() {
      videoUrl = vidUrl;
      controller = VideoPlayerController.network(videoUrl);
      controller!.initialize();
      controller!.setLooping(true);
      controller!.setVolume(2.0);
      controller!.play();
      setState(() {
        controller!.play();
      });
    });
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Post Interview')),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    validator: (v) {
                                      if (v!.isNotEmpty) return null;
                                      return 'Enter details ';
                                    },
                                    controller: companynameController,
                                    enabled: isEnabled,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      labelText: "Company Name",
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    validator: (v) {
                                      if (v!.isNotEmpty) return null;
                                      return 'Enter details';
                                    },
                                    enabled: isEnabled,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      labelText: "Job Name",
                                    ),
                                    controller: jobNameController,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.26,
                                height: 140,
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImagePkr(
                                                getimageLink: getImagelink,
                                              )),
                                    );
                                  },
                                  child: Text(
                                    'Pick place Image',
                                    style: TextStyle(fontSize: 12),
                                  )),
                            ],
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (v) {
                            if (v!.isNotEmpty) return null;
                            return 'Enter Job Description/ work details';
                          },
                          enabled: isEnabled,
                          maxLines: 3,
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
                            labelText: "Job Description/ work details",
                          ),
                          controller: jobDescriptionController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (v) {
                            if (v!.isNotEmpty) return null;
                            return 'Enter Interview Description';
                          },
                          enabled: isEnabled,
                          maxLines: 3,
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
                            labelText: "Documents Required",
                          ),
                          controller: interviewDescriptionController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            validator: (v) {
                              if (v!.isNotEmpty) return null;
                              return 'Enter details';
                            },
                            enabled: isEnabled,
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
                                labelText: "Company Address"),
                            controller: companyAddressController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            validator: (v) {
                              if (v!.isNotEmpty) return null;
                              return 'Enter details';
                            },
                            enabled: isEnabled,
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
                                labelText: 'Qualification Required'),
                            controller: qualificationController),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (v) {
                            if (v!.isNotEmpty) return null;
                            return 'Enter details';
                          },
                          enabled: isEnabled,
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
                              labelText: 'Experience Required/worker details'),
                          controller: experienceController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DateTimeField(
                          enabled: isEnabled,
                          validator: (v) {
                            if (v == null
                                ? true
                                : v.difference(DateTime.now()) <
                                    Duration(days: 0))
                              return 'Enter correct Details';
                            return null;
                          },
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
                              labelText: 'Interview Date and Time'),
                          format: format,
                          onShowPicker: (context, currentValue) async {
                            final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    currentValue ?? DateTime.now()),
                              );
                              workstartdate = DateTimeField.combine(date, time);
                              return DateTimeField.combine(date, time);
                            } else {
                              return currentValue;
                            }
                          },
                        ),
                      ),
                      /*--------------------------- My Chnages  ---------------------------------------------------- */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: TextFormField(
                              validator: (v) {
                                if (v!.isNotEmpty) return null;
                                return 'Enter male seats';
                              },
                              controller: maleSeatController,
                              enabled: isEnabled,
                              decoration: InputDecoration(
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
                                  labelText: 'Male Seat'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.43,
                            child: TextFormField(
                              validator: (v) {
                                if (v!.isNotEmpty) return null;
                                return 'Enter female seats';
                              },
                              controller: femaleSeatController,
                              enabled: isEnabled,
                              decoration: InputDecoration(
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
                          validator: (v) {
                            if (v!.isNotEmpty) return null;
                            return 'Enter working hours/day';
                          },
                          controller: workingDaysController,
                          enabled: isEnabled,
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
                              labelText: 'Enter working hours/day'),
                          // onTap: () {},
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (v) {
                            if (v!.isNotEmpty) return null;
                            return 'Enter salary';
                          },
                          controller: salaryController,
                          enabled: isEnabled,
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
                              labelText: 'Salary/per day'),
                          // onTap: () {},
                        ),
                      ),
                      //-----------Check boxes for post job screen
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
                                  /*  Row(
                                    children: [
                                      Text('Extra Form Needed'),
                                      Spacer(
                                          ////flex: 2,
                                          ),
                                      Checkbox(
                                          value: extraformController,
                                          onChanged: (val) {
                                            setState(() {
                                              extraformController =
                                                  !extraformController;
                                            });
                                          }),
                                    ],
                                  ),
                                 */
                                  // Row(
                                  //   children: [
                                  //     Text('Male Seat'),
                                  //     Spacer(),
                                  //     Checkbox(
                                  //         value: maleseetController,
                                  //         onChanged: (val) {
                                  //           setState(() {
                                  //             maleseetController =
                                  //                 !maleseetController;
                                  //           });
                                  //         }),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Text('Monthly Pay'),
                                      Spacer(
                                          ////flex: 2,
                                          ),
                                      Checkbox(
                                          value: monthlypayController,
                                          onChanged: (val) {
                                            setState(() {
                                              monthlypayController =
                                                  !monthlypayController;
                                            });
                                          }),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Per Day Amount'),
                                      Spacer(
                                          ////flex: 2,
                                          ),
                                      Checkbox(
                                          value: perdayamountController,
                                          onChanged: (val) {
                                            setState(() {
                                              perdayamountController =
                                                  !perdayamountController;
                                            });
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Text('Female Seat'),
                                  //     Spacer(),
                                  //     Checkbox(
                                  //         value: femaleseetController,
                                  //         onChanged: (val) {
                                  //           setState(() {
                                  //             femaleseetController =
                                  //                 !femaleseetController;
                                  //           });
                                  //         }),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Text(
                                        'Room Facility',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Spacer(),
                                      Checkbox(
                                          value: roomfacilityController,
                                          onChanged: (val) {
                                            setState(() {
                                              roomfacilityController =
                                                  !roomfacilityController;
                                            });
                                          }),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Food Facility'),
                                      Spacer(),
                                      Checkbox(
                                          value: foodController,
                                          onChanged: (val) {
                                            setState(() {
                                              foodController = !foodController;
                                            });
                                          }),
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
                                          fontWeight: FontWeight.w700,
                                          fontSize: 25)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (v) {
                                  if (v!.isNotEmpty) return null;
                                  return 'Enter details';
                                },
                                enabled: isEnabled,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    labelText: 'Name'),
                                controller: paymentNameController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (v) {
                                  if (v!.isNotEmpty) return null;
                                  return 'Enter details';
                                },
                                enabled: isEnabled,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    labelText: 'Position'),
                                controller: paymentPositionController,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DateTimeField(
                                enabled: isEnabled,
                                validator: (v) {
                                  if (v == null
                                      ? true
                                      : v.difference(DateTime.now()) <
                                          Duration(days: 0))
                                    return 'Enter correct Details';
                                  return null;
                                },
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    labelText: 'Payment Date and Time'),
                                format: format,
                                onShowPicker: (context, currentValue) async {
                                  final date = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate:
                                          currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          currentValue ?? DateTime.now()),
                                    );
                                    paymentdatetime =
                                        DateTimeField.combine(date, time);
                                    return DateTimeField.combine(date, time);
                                  } else {
                                    return currentValue;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async {
                                if (imageUrl == 'https://picsum.photos/200') {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      animType: AnimType.RIGHSLIDE,
                                      desc: 'Please Upload an image to continue',
                                      btnCancelText: 'Ok',
                                      btnOkColor: Colors.red,
                                      btnOkOnPress: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ImagePkr(
                                                    getimageLink: getImagelink,
                                                  )),
                                        );
                                      })
                                    ..show();
                                  return;
                                } else if (_formkey.currentState!.validate()) {
                                  await AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.QUESTION,
                                    animType: AnimType.RIGHSLIDE,
                                    desc: 'Are you sure you want to post interview?',
                                    // btnOkColor: Colors.g,
                                    btnCancelColor: Colors.green,
                                    btnOkColor: Colors.red,
                                    btnCancelText: 'No',
                                    btnCancelOnPress: () {
                                      return;
                                    },
                                    btnOkOnPress: () {
                                      // Timestamp paymentdate =
                                      //     Timestamp.fromDate(DateTime.parse(
                                      //         paymentDateController.text));

                                      /*--------------------------- time correction ---------------------------------------------------- */

                                      Map<String, dynamic> data = {
                                        "company_name":
                                            companynameController.text,
                                        "job_name": jobNameController.text,
                                        "job_description":
                                            jobDescriptionController.text,
                                        "company_address":
                                            companyAddressController.text,
                                        "qualification":
                                            qualificationController.text,
                                        "experience": experienceController.text,
                                        // // "extra_form": extraformController,
                                        "male_seat": maleSeatController.text,
                                        "female_seat":
                                            femaleSeatController.text,
                                        "work_start_date":
                                            Timestamp.fromDate(workstartdate),
                                        "payment_date":
                                            Timestamp.fromDate(paymentdatetime),
                                        "working_days":
                                            workingDaysController.text,
                                        "salary": salaryController.text,
                                        "room_facility": roomfacilityController,
                                        "per_day_amount":
                                            perdayamountController,
                                        "food_facility": foodController,
                                        // "work_start": workstart,
                                        // "work_off": workoff,
                                        "payment_name":
                                            paymentNameController.text,
                                        "payment_position":
                                            paymentPositionController.text,
                                        // "payment_time": paymenttime,
                                        "user_id": FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString(),
                                        "is_active": true,
                                        "applicants": 0,
                                        "work_image": imageUrl,
                                        "interview": {
                                          "monthly_amount":
                                              monthlypayController,
                                          "interview_desc":
                                              interviewDescriptionController
                                                  .text
                                        }
                                      };
                                      print(
                                          "-----------------------dfsdfdsfsdsdf---------------");
                                      PostJob("jobposts", data);
                                      // : AwesomeDialog(
                                      //     context: context,
                                      //     dialogType: DialogType.WARNING,
                                      //     animType: AnimType.RIGHSLIDE,
                                      //     title: 'Login',
                                      //     btnOkColor: Colors.blue,
                                      //     btnOkOnPress: () {
                                      //       Navigator.of(context).pushNamed(
                                      //         LoginScreen.routeName,
                                      //       );
                                      //     },
                                      //   ).show();
                                    },
                                  ).show();
                                }
                              },
                              child: Text('Submit')),
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
