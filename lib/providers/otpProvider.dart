import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //get user => _auth.currentUser;
  String otpfromuser = '';
  String contactNum = '';
  String verificationId = '';
  bool isAuth = false;
  bool otpSent = false;
  // get Otpfromuser => otpfromuser;
  void get_otp_from_user(String otp) {
    otpfromuser = otp;
    print(
        'otp in pprovider --------------------------------------------$otpfromuser');
    // notifyListeners();
  }

  void getNumber(String number) {
    contactNum = number;
    print(
        'num in pprovider --------------------------------------------$contactNum');
    // notifyListeners();
  }

  //SIGN IN METHOD
  Future signIn() async {
    otpSent = false;
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      // this.actualCode = verificationId;
      print(verificationId);
      this.verificationId = verificationId;
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print("varification failed");
      if (authException.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
    };
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential auth) async {
      //_authCredential = auth;
      print('varification completed');
      this.verificationId = verificationId;
      // await _auth.signInWithCredential(auth);
    };
    final PhoneCodeSent codeSent =
        (String verificationId, int? forceResendingToken) async {
      print(' varification code sent to ' + contactNum);
      this.verificationId = verificationId;
      print(verificationId);
      this.otpSent = true;
      notifyListeners();
      // String smsCode = otpfromuser;
      // // Create a PhoneAuthCredential with the code
      //PhoneAuthCredential credential = PhoneAuthProvider.credential(smsCode: otpfromuser, verificationId: verificationId);
      // // Sign the user in (or link) with the credential
      //await _auth.signInWithCredential(credential);
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: contactNum,
          timeout: Duration(seconds: 100),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(
              smsCode: otpfromuser, verificationId: verificationId));
    } catch (e) {
      print(e);
    }
  }

  Future<void> isUserLoggedIn() async {
    if (_auth.currentUser != null) {
      isAuth = true;
      notifyListeners();
    }
  }

  Future signOut() async {
    await _auth.signOut();
    print('signout');
    isAuth = false;
    notifyListeners();
  }
}