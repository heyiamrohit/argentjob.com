import 'package:flutter/material.dart'; 
import 'package:lottie/lottie.dart';

class NetworkError extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(body: Center(child: Column(
        children: [
          Lottie.asset('assets/lottie/no-internet.json'),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Network Error!",
                    style: TextStyle(
                    fontSize: 20)),
            ),
          ), 
        ],
      )),) 
    );
  }
}