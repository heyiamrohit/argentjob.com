import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class ComplainBox extends StatefulWidget {
  static const routeName = '/ComplainBox';

  @override
  _ComplainBoxState createState() => _ComplainBoxState();
}

class _ComplainBoxState extends State<ComplainBox> {
  bool isloading = false;

  TextEditingController user_id_textController = TextEditingController();

  TextEditingController job_id_textController = TextEditingController();

  TextEditingController discription_textController = TextEditingController();
  Future addComplain(String uid, String jobid, String discription) async {
    // await
    setState(() {
      isloading = true;
    });
    try {
      if (_formkey.currentState!.validate()) {
        print('validate done');
        await FirebaseFirestore.instance.collection("complainbox").add({
          "description": discription_textController.text,
          "against": job_id_textController.text,
          "userid": FirebaseAuth.instance.currentUser!.uid,
        }).then((value) {
          setState(() {
            isloading = false;
          });

          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: const Text('Complaint added'),
            duration: Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        });
      }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: const Text('Network Error'),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Navigator.pop(context);
    }
  }

  String userid = "";
  @override
  void initState() {
    userid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complain Box'),
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: LottieBuilder.asset("assets/lottie/letter.json"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: userid));
                        final snackBar = SnackBar(
                          content: const Text('User Id copied'),
                          backgroundColor: (Colors.black),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar); 
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextFormField(
                          // maxLength: 1,
                          // controller: discription_textController,
                          enabled: false,
                  
                          initialValue: userid.substring(0, 10) + "...",
                          decoration: InputDecoration(
                            prefixText: "User ID  ",
                            prefixIcon: Icon(Icons.badge),
                            suffixIcon: Icon(Icons.copy_all),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0)),
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          // maxLines: 4,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: job_id_textController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Complaint Against";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_add_alt_1_outlined),
                          hintText: 'Complaint Against',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
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
                        ),
                      ),
                    ),
                    /*--------------------------- User id ---------------------------------------------------- */
                    /*--------------------------- discription ---------------------------------------------------- */
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // maxLength: 3,
                        controller: discription_textController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Desctiption";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
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
                        ),
                        maxLines: 4,
                      ),
                    ),
                    /*--------------------------- discription ---------------------------------------------------- */
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            child: TextButton(
                                child: Text('Submit',
                                    style: TextStyle(fontSize: 18)),
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            EdgeInsets.all(8)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Theme.of(context).primaryColor,
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )))),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                     addComplain(
                                        user_id_textController.toString(),
                                        job_id_textController.toString(),
                                        discription_textController.toString());
                                  }
                                 
                                }),
                          ),
                        ),
                        Spacer(
                            //flex: 2,
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
