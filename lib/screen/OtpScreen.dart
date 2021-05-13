import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AddInfoScreen.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;
  bool isAddInfoScreenVerified = false;

  String userId = "";
  String userPhone = "";

  saveValueToSharedPrefs(String userId, String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", userId);
    prefs.setString("phone", userPhone);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        userId = authCredential.user.uid;
        saveValueToSharedPrefs(userId, userPhone);
        setState(() {
          isAddInfoScreenVerified = true;
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            hintText: "Phone Number",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });
            if (phoneController.text.toString().trim().length == 10) {
              userPhone = phoneController.text.toString().trim();
              await _auth.verifyPhoneNumber(
                phoneNumber: "+91${phoneController.text.toString().trim()}",
                verificationCompleted: (phoneAuthCredential) async {
                  userPhone = phoneController.text.toString().trim();
                  setState(() {
                    showLoading = false;
                  });
                  //signInWithPhoneAuthCredential(phoneAuthCredential);
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text(verificationFailed.message)));
                },
                codeSent: (verificationId, resendingToken) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
              );
            } else {}
          },
          child: Text("SEND"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(),
        TextField(
          controller: otpController,
          decoration: InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        FlatButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text("VERIFY"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  bool isLoading = true;

  Future<bool> isPrefsHaveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("uid") && prefs.containsKey("phone")) {
      setState(() {
        isAddInfoScreenVerified = true;
      });
      return true;
    }
    return false;
  }

  @override
  void initState() {
    isPrefsHaveValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
        future: isPrefsHaveValue(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : isAddInfoScreenVerified
                  ? AddInfoScreen()
                  : Container(
                      child: currentState ==
                              MobileVerificationState.SHOW_MOBILE_FORM_STATE
                          ? getMobileFormWidget(context)
                          : getOtpFormWidget(context),
                      padding: const EdgeInsets.all(16),
                    );
        },
      ),
    );
  }
}

// body: isAddInfoScreenVerified
// ? AddInfoScreen()
//     : Container(
// child: showLoading
// ? Center(
// child: CircularProgressIndicator(),
// )
// : currentState ==
// MobileVerificationState.SHOW_MOBILE_FORM_STATE
// ? getMobileFormWidget(context)
// : getOtpFormWidget(context),
// padding: const EdgeInsets.all(16),
// ),
