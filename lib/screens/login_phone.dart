import 'package:firebase_mxpert/screens/check_otp.dart';
import 'package:firebase_mxpert/screens/sign_up.dart';
import 'package:firebase_mxpert/utils/snack_bar.dart';
import 'package:firebase_mxpert/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogPhone extends StatefulWidget {
  LogPhone({Key? key}) : super(key: key);

  @override
  _LogPhoneState createState() => _LogPhoneState();
}

class _LogPhoneState extends State<LogPhone> {
  //
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final _phone = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Phone"),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 120,
                ),
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 30),
              const Text(
                "Login to continue",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 30),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: TextFormField(
              //     keyboardType: TextInputType.number,
              //     controller: _phone,
              //     decoration: const InputDecoration(hintText: "+ 91 "),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android_outlined),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 0.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          BorderSide(color: Colors.grey.shade400, width: 0.5),
                    ),
                    hintText: 'Phone Number',
                  ),
                ),
              ),
              SizedBox(height: 10),
              RoundedButton(
                  loading: loading,
                  title: "GET OTP",
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    auth.verifyPhoneNumber(
                        phoneNumber: "+91" + _phone.text,
                        verificationCompleted: (_) {
                          setState(() {
                            loading = false;
                          });
                        },
                        verificationFailed: (e) {
                          setState(() {
                            loading = false;
                          });
                          Utils().snackBar("Faild", context);
                        },
                        codeSent: (String verificationId, int? toeken) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyOtp(
                                        verificationId: verificationId,
                                      )));
                        },
                        codeAutoRetrievalTimeout: (e) {
                          Utils().snackBar("Time Out", context);
                        });
                  }),
              SizedBox(height: 100),
              const Text(
                "or continue With",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonlogin(
                    callback: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    image: "assets/images/Google@3x.png",
                    text: 'Google',
                  ),
                  buttonlogin(
                    image: "assets/images/image 45.png",
                    text: 'facebook',
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class buttonlogin extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback? callback;
  const buttonlogin({
    super.key,
    required this.image,
    required this.text,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Card(
        child: SizedBox(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  image,
                  height: 30,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
