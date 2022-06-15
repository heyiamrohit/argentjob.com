//  shared_preferences: ^2.0.7

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ShardPrfnc with ChangeNotifier {
  /*--------------------------- string ---------------------------------------------------- */

  addStringToSF(String title, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(title, value);
  }

  getStringValuesSF(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? stringValue = prefs.getString(title);
    return stringValue;
  }
  /*--------------------------- string ---------------------------------------------------- */
  /*--------------------------- int ---------------------------------------------------- */

  addIntToSF(String title, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(title, value);
  }

  getIntValuesSF(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(title);
    return intValue;
  }

  /*--------------------------- int ---------------------------------------------------- */
  /*--------------------------- double ---------------------------------------------------- */

  addDoubleToSF(String title, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(title, value);
  }

  getDoubleValuesSF(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double? doubleValue = prefs.getDouble(title);
    return doubleValue;
  }

  /*--------------------------- double ---------------------------------------------------- */
  /*--------------------------- bool ---------------------------------------------------- */

  addBoolToSF(String title, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(title, value);
  }

  getBoolValuesSF(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool(title)??false;
    return boolValue;
  }

  /*--------------------------- bool ---------------------------------------------------- */

}
