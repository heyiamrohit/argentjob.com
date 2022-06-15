
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tatkal_jobs_app/models/notification.dart';

class NotificationProvider with ChangeNotifier {
  List<Notifications> notifications_list = [];
  bool loading = true;

  Future fetchNotifications() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();
    notifications_list.clear();
    notifications_list = querySnapshot.docs
        .map((doc) => Notifications(
            title: doc['title'],
            subtitle: doc['subtitle'],
            discription: doc['discription'],
            date: doc['date']))
        .toList();
  }
}
