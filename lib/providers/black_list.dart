import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tatkal_jobs_app/models/blacklist.dart'; 

class BlackListProvider with ChangeNotifier {
  List<BlackList> black_list = [];
  bool loading = true;

  Future fetchblacklist() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('blacklist').get();
    black_list.clear();
    black_list = querySnapshot.docs
        .map((doc) => BlackList(
            id: doc['id'],
            discription: doc['discription'],
            fine_amount: doc['amount']))
        .toList();
  }
}
