import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_mxpert/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/snack_bar.dart';
import '../widget/round_button.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;
  VerifyOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final _phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor().primaryColor.withOpacity(0.54)),
                  child: Center(
                      child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "OTP Verification",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                textAlign: TextAlign.center,
                "Enter the verification code we just sent on your email address.",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _phone,
                decoration: InputDecoration(
                  hintText: "6 Digit OTP",
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20)), // Added outline border
                ),
              ),
            ),
            RoundedButton(
              loading: loading,
              title: "Verify",
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: _phone.text.toString(),
                );

                try {
                  await auth.signInWithCredential(credential);

                  // Create a folder in Firestore
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(auth.currentUser!.uid)
                      .set({
                    'phone': _phone.text.toString(),
                    'createdAt': Timestamp.now(),
                  });

                  setState(() {
                    loading = false;
                  });

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(title: 'Home'),
                    ),
                  );
                } catch (e) {
                  Utils().snackBar(e.toString(), context);
                  setState(() {
                    loading = false;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
