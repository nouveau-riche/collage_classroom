import 'package:flutter/material.dart';

import '../utility/google_signin.dart';

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(25, 128, 58, 1),
      body: Column(
        children: [
          Container(
            height: mq.height * 0.36,
            child: Image.asset("assets/images/logo.jpg"),
          ),
          Container(
              height: mq.height * 0.1,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Collage ',
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    'Classroom',
                    style: const TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )),
          Container(
            height: mq.height * 0.12,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(2),
                    child: const Text(
                      'Classroom helps classes communicate, save time and stay organised.',
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: mq.height * 0.05,
            child: RaisedButton(
              child: const Text(
                'GET STARTED',
                style: const TextStyle(
                    color: const Color.fromRGBO(25, 128, 58, 1), fontSize: 17),
              ),
              onPressed: () {
                signInWithGoogle(context).whenComplete(() {
                  print('done successfully');
                });
              },
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: mq.height * 0.25,
          ),
          Container(
            padding: EdgeInsets.all(2),
            height: mq.height * 0.1,
            child: const Text(
              'By joining you agree to share contact information with people in your class.',
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
