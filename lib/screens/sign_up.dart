import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_mxpert/screens/home_page.dart';
import 'package:firebase_mxpert/screens/login.dart';
import 'package:firebase_mxpert/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/snack_bar.dart';
import '../widget/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _pswd = TextEditingController();
  TextEditingController _conPwd = TextEditingController();
  TextEditingController _phone = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().primaryColor,
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Create Account",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(20),
                          ), // Added outline border
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _pswd,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(20),
                            ), // Added outline border
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _conPwd,
                          decoration: InputDecoration(
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(20),
                            ), // Added outline border
                          ),
                          validator: (value) {
                            if (value!.isEmpty || _pswd.text != _conPwd.text) {
                              return "Enter Confirm Password";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: _phone,
                          decoration: InputDecoration(
                            hintText: "Phone",
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(20),
                            ), // Added outline border
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Phone";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 50),
                      RoundedButton(
                        loading: loading,
                        title: 'NEXT',
                        onTap: () {
                          SignUp();
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Do you hanve an account ? ",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogINPage(),
                                  ),
                                );
                              },
                              child: Text("Login",
                                  style: TextStyle(fontSize: 18))),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void SignUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      _auth
          .createUserWithEmailAndPassword(
              email: _email.text.trim().toString(),
              password: _pswd.text.toString().trim())
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .set({
          'email': _email.text.trim(),
          'phone': _phone.text.trim(),
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
      }).onError(
        (error, stackTrace) {
          setState(() {
            loading = false;
          });
          Utils().snackBar(error.toString(), context);
        },
      );
    }
  }
}
