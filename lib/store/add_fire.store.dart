import 'package:firebase_mxpert/widget/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddFireStore extends StatefulWidget {
  const AddFireStore({
    Key? key,
  }) : super(key: key);

  @override
  State<AddFireStore> createState() => _AddFireStoreState();
}

class _AddFireStoreState extends State<AddFireStore> {
  final fireStore = FirebaseFirestore.instance.collection('users');

  final _add = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Fire Store'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text("Add Fire Store"),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _add,
              decoration: const InputDecoration(hintText: "Add"),
            ),
          ),
          const SizedBox(height: 20),
          RoundedButton(
              loading: false,
              title: "Add",
              onTap: () {
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                fireStore.doc(id).set({
                  'title': _add.text,
                  'id': id,
                });
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
