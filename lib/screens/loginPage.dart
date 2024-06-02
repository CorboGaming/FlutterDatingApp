// ignore_for_file: prefer_final_fields, avoid_print, library_private_types_in_public_api, file_names, use_key_in_widget_constructors, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/homeProfile.dart';
import 'package:mahram_optimise_v01/screens/mahramWidget.dart';
import 'package:mahram_optimise_v01/screens/profile.dart';
import 'package:mahram_optimise_v01/screens/signupemail.dart';
import 'package:mahram_optimise_v01/screens/survey.dart';
import 'package:mahram_optimise_v01/services/authService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool mahramValide = false;
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final currentHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/mahram.png'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 0.9271],
            colors: [
              Color.fromRGBO(0, 0, 0, 0.8),
              Color.fromRGBO(0, 0, 0, 0),
              Color.fromRGBO(21, 21, 21, 0.8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Positioned(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: AssetImage('assets/image/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 200,
              ),
              width: MediaQuery.sizeOf(context).width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 60,
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          UserCredential? userCredential =
                              await _authService.signInWithGoogle().then(
                            (userCredential) async {
                              String email =
                                  userCredential!.user!.email as String;
                              String uid = userCredential.user!.uid;
                              print(userCredential.user!.email);
                              bool checkMahram =
                                  await _authService.checkIfMahram(
                                email,
                              );

                              if (checkMahram) {
                                print('exist in mahrams');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MahramWidget()));
                              }

                              bool checkUser =
                                  await _authService.searchUserByEmail(email);

                              if (checkUser) {
                                print('exist in users');
                                await _authService
                                    .getUserFromFirestore(uid)
                                    .then((user) async {
                                  if (user!.gender.contains('Male')) {
                                    setState(() {
                                      user.userCredential = userCredential;
                                    });
                                    print('this is a male');
                                    await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeProfile(user),
                                      ),
                                    );
                                  } else if (user.gender.contains('Female')) {
                                    print('this is female');
                                    bool checkValidationMahram =
                                        await _authService
                                            .checkIfMahramvalid(uid);
                                    print(checkValidationMahram);
                                    if (checkValidationMahram) {
                                      await Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HomeProfile(user),
                                        ),
                                      );
                                    } else if (checkValidationMahram == false) {
                                      setState(() {
                                        user.userCredential = userCredential;
                                      });
                                      String vcode = await _authService
                                          .generateVerificationCode();

                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Profile(
                                            user,
                                            vcode,
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                });
                              } else if (checkUser == false &&
                                  checkMahram == false) {
                                print('doesnt exist in users');
                                UsersEntity newuser = UsersEntity();
                                setState(() {
                                  newuser.userCredential = userCredential;
                                });
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Survey(newuser),
                                  ),
                                );
                              }
                              return null;
                            },
                          );
                        },
                        icon: SvgPicture.asset(
                          'assets/image/google.svg',
                          height: 24,
                          width: 24,
                        ),
                        label: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            letterSpacing: 0,
                            color: Colors.black.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: TextButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Continue with email',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            letterSpacing: 0,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Positioned(
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1,
                        letterSpacing: 0.5,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      children: [
                        TextSpan(
                          text: 'I agree to our ',
                        ),
                        TextSpan(
                          text: 'Terms and Privacy Policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
