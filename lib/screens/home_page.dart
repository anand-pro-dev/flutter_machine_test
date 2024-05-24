import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mxpert/screens/login.dart';
import 'package:firebase_mxpert/screens/login_phone.dart';
import 'package:firebase_mxpert/utils/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? title;
  HomePage({required this.title});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogPhone()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppColor().theme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Row(
          children: [
            Spacer(),
            Image.asset(
              "assets/images/menu-variant.png",
              width: 30,
            ),
          ],
        ),
        title: Image.asset(
          "assets/images/logo.png",
          width: 60,
        ),
        actions: [
          Image.asset(
            "assets/images/Search@3x.png",
            width: 20,
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final users = snapshot.data!.docs;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index].data() as Map<String, dynamic>;
                    final phone = user['phone'];

                    return ListTile(
                      title: Text('Mobile no. : $phone'),
                    );
                  },
                ),
              ),
              Image.asset("assets/images/Group 1171274903.png"),
            ],
          );
        },
      ),
    );
  }
}
