import 'package:firebase_mxpert/screens/home_page.dart';
import 'package:firebase_mxpert/screens/login_phone.dart';
import 'package:firebase_mxpert/screens/sign_up.dart';
import 'package:firebase_mxpert/utils/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widget/round_button.dart';

class LogINPage extends StatefulWidget {
  const LogINPage({Key? key}) : super(key: key);

  @override
  State<LogINPage> createState() => _LogINPageState();
}

class _LogINPageState extends State<LogINPage> {
  //
  final _auth = FirebaseAuth.instance;
  //
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pswd = TextEditingController();
  //
  void login() async {
    _auth
        .signInWithEmailAndPassword(
            email: email.text.toString(), password: pswd.text.toString())
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    title: 'Home',
                  )));
      // Utils().snackBar(value.user.toString(), context);
    }).onError((error, stackTrace) {
      Utils().snackBar(error.toString(), context);
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("log in"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Log in to the Accounts",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        controller: email,
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
                      const SizedBox(height: 20),
                      SizedBox(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: pswd,
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
                      const SizedBox(height: 20),
                      RoundedButton(
                        title: 'Login',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            login();
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      // RoundedButton(
                      //     title: "lOGN WITH PHONE",
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => LogPhone()));
                      //     }),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Do you want to create an ? ",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text("Sign up",
                                  style: TextStyle(fontSize: 18))),
                        ],
                      ),
                      // RoundedButton(
                      //     title: "Sign Up",
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => SignUpScreen()));
                      //     }),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

signInWithGoogle() async {
  GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
  print(userCredential.user?.displayName);
}
