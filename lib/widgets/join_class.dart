import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collage_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';

bool isClassCodeValid = false;
TextEditingController _codeController = TextEditingController();

Future<Widget> buildJoinClass(BuildContext context) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      context: context,
      builder: (ctx) => Container(
            height: mq.height * 0.8,
            child: Column(
              children: [
                buildAppBar(context),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    'Ask your teacher for the class code, then\nenter it here.',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                buildClassCodeField(mq.width * 0.85)
              ],
            ),
          ));
}

Widget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.clear,color: Colors.black87,),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    ),
    title: const Text(
      'Join class',
      style: const TextStyle(fontSize: 18, color: Colors.black),
    ),
    actions: [
      TextButton(
        child: const Text(
          'Join',
          style: const TextStyle(fontSize: 16,color: kPrimaryColor),
        ),
        onPressed: isClassCodeValid == false
            ? null
            : () async {
                User user = FirebaseAuth.instance.currentUser;
                DocumentSnapshot snapshot = await FirebaseFirestore.instance
                    .collection('singleClass')
                    .doc(_codeController.text)
                    .get();
                joinClassOnFirebase(
                    classId: _codeController.text,
                    name: snapshot.data()['name'],
                    section: snapshot.data()['section'],
                    subject: snapshot.data()['subject'],
                    studentUID: user.uid,
                    studentName: user.displayName,
                    instructorPhotoUrl: snapshot.data()['photoUrl'],
                    imageUrl: user.photoURL);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _codeController.clear();
              },
      )
    ],
  );
}

Widget buildClassCodeField(double width) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: width,
    child: TextField(
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        labelText: 'Class code',
        labelStyle: const TextStyle(color: Colors.black87),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 1, color: Colors.blue),
        ),
      ),
      controller: _codeController,
      onChanged: (_value) {
        if (_value.length > 5) {
          isClassCodeValid = true;
        }
      },
    ),
  );
}
