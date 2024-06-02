// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/mahramInfo.dart';
import 'package:mahram_optimise_v01/screens/origineSelect.dart';

class VerifiedCode extends StatefulWidget {
  final UsersEntity currentUser;

  VerifiedCode(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<VerifiedCode> createState() => _VerifiedCodeState();
}

class _VerifiedCodeState extends State<VerifiedCode> {
  @override
  Widget build(BuildContext context) {
    final currentWidht = MediaQuery.of(context).size.width;
    final currentHight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        width: currentWidht,
        height: currentHight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 25,
                        top: 30,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "You're ",
                              style: TextStyle(
                                color: Color.fromARGB(255, 15, 15, 15),
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
                              ),
                            ),
                            TextSpan(
                              text: "verified\n",
                              style: TextStyle(
                                color: Color.fromARGB(255, 49, 196, 141),
                                fontWeight: FontWeight.w600,
                                fontSize: 32,
                              ),
                            ),
                            TextSpan(
                              text: "Now create your profile",
                              style: TextStyle(
                                color: Color.fromARGB(255, 15, 15, 15),
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 322,
                      margin: EdgeInsets.all(45),
                      child: const Text(
                        "Ready to find your perfect partner?",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(25),
                      child: const Text(
                        'Now start building your profile so we can show you the right Muslim partner in a few steps',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w100,
                          color: Color(0xff595959),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: 362,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 49, 196, 141),
                ),
                onPressed: () async {
                  setState(() {
                    if (widget.currentUser.gender.contains('Male')) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OriginSelect(
                            widget.currentUser,
                          ),
                        ),
                      );
                    } else if (widget.currentUser.gender.contains('Female')) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MahramInfo(widget.currentUser),
                        ),
                      );
                    } else {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ErrorHandler(),
                      //   ),
                      // );
                    }
                  });
                },
                child: const Text(
                  'Create Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
