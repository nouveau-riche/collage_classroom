import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';

TextEditingController _className = TextEditingController();
TextEditingController _secName = TextEditingController();
TextEditingController _subjectName = TextEditingController();

bool isSubjectNameValid = false;
bool isClassNameValid = false;
bool isSectionNameValid = false;

Future<Widget> buildCreateClass(BuildContext context) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      builder: (ctx) => Container(
            height: mq.height * 0.8,
            child: Column(
              children: [
                buildAppBar(context),
                buildClassNameField(mq.width * 0.9),
                buildSecNameField(mq.width * 0.9),
                buildSubjectNameField(mq.width * 0.9),
              ],
            ),
          ));
}

Widget buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15))),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(
        Icons.clear,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    ),
    title: const Text(
      'Create class',
      style: const TextStyle(fontSize: 18, color: Colors.black),
    ),
    actions: [
      FlatButton(
        child: const Text(
          'Create',
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: isSubjectNameValid == false ||
                isClassNameValid == false ||
                isSectionNameValid == false
            ? null
            : () {
                User user = FirebaseAuth.instance.currentUser;
                createClassOnFirebase(
                    uid: user.uid,
                    name: _className.text,
                    section: _secName.text,
                    subject: _subjectName.text,
                    instructor: user.displayName,
                    instructorPhotoUrl: user.photoURL,
                    isInst: true);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                _className.clear();
                _secName.clear();
                _subjectName.clear();
              },
      )
    ],
  );
}

Widget buildClassNameField(double width) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextField(
      cursorColor: Colors.blue,
      decoration: const InputDecoration(
        hintText: 'Class name',
        labelText: 'Class name',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      autofocus: true,
      controller: _className,
      onChanged: (_value) {
        if (_value.length > 0) {
          isClassNameValid = true;
        }
      },
    ),
  );
}

Widget buildSecNameField(double width) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextField(
      decoration: const InputDecoration(
        hintText: 'Section',
        labelText: 'Section',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      controller: _secName,
      onChanged: (_value) {
        if (_value.length > 0) {
          isSectionNameValid = true;
        }
      },
    ),
  );
}

Widget buildSubjectNameField(double width) {
  return Container(
    width: width,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: TextField(
      cursorColor: Colors.blue,
      decoration: const InputDecoration(
        hintText: 'Subject',
        labelText: 'Subject',
        labelStyle: const TextStyle(color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.blue),
        ),
      ),
      autofocus: true,
      controller: _subjectName,
      onChanged: (_value) {
        if (_value.length > 0) {
          isSubjectNameValid = true;
        }
      },
    ),
  );
}
