import 'package:collage_classroom/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../utility/database.dart';

Future<Widget> showUnEnrolBottomSheet(
    BuildContext context, String classId) async {
  final mq = MediaQuery.of(context).size;
  return await showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
            height: mq.height * 0.1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: const Text(
                    'Unenroll',
                    style: const TextStyle(fontSize: 19,color: kTextColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showUnEnrolAlert(context, classId);
                  },
                ),
              ],
            ),
          ));
}

showUnEnrolAlert(BuildContext context, String classId) {
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            title: const Text(
              'Unenroll',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            content: const Text(
              "By doing this, you'll no longer be able to see the class or participate in it.",
              style: const TextStyle(color: Colors.black87),
            ),
            actions: [
              TextButton(
                child: const Text(
                  'CANCEL',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  'UNENROL',
                  style: const TextStyle(fontWeight: FontWeight.w500,color: kPrimaryColor),
                ),
                onPressed: () {
                  User user = FirebaseAuth.instance.currentUser;
                  unEnrolFromJoinedClass(uid: user.uid, classId: classId);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
}
