import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tatkal_jobs_app/screens/Login_Screen.dart';

class LoginError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Lottie.asset(
              'assets/lottie/login.json',
              height: MediaQuery.of(context).size.height * 0.6,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(onTap: (){
                  Navigator.of(context)
                                    .pushNamed(
                                      LoginScreen.routeName,  
                                      );
                          
                },
                  child: Text("You need to Login/Register First",
                      style: TextStyle(fontSize: 20,color:   Theme.of(context).primaryColor,)),
                ),
              ),
            ),
          ],
        )),
      ),
    ));
  }
}
