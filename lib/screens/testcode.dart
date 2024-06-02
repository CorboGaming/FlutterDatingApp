// ignore_for_file: prefer_final_fields, avoid_print, library_private_types_in_public_api, file_names, use_key_in_widget_constructors, use_build_context_synchronously, prefer_const_constructors, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
        height: currentHight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/mahram.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 80.0), // Added space at the top
              Center(
                child: Container(
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
              SizedBox(height: currentHight <= 800 ? 90 : 150),
              SizedBox(
                height: 65,
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    UserCredential? userCredential =
                        await _authService.signInWithGoogle().then(
                      (userCredential) async {
                        String email = userCredential!.user!.email as String;
                        String uid = userCredential.user!.uid;
                        print(userCredential.user!.email);
                        bool checkMahram = await _authService.checkIfMahram(
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
                                  await _authService.checkIfMahramvalid(uid);
                              print(checkValidationMahram);
                              if (checkValidationMahram) {
                                await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeProfile(user),
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
                        } else if (checkUser == false && checkMahram == false) {
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  text: 'Continue with Google',
                  padding: const EdgeInsets.all(6.0),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                  child: Text(
                    'Continue with email',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.left,
                  )),
              SizedBox(height: currentHight <= 800 ? 40 : 50),
              Container(
                alignment: Alignment.bottomCenter,
                margin:
                    const EdgeInsets.only(bottom: 10.0, left: 45, right: 45),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 250, 250),
                    ),
                    children: [
                      TextSpan(
                        text: 'You agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          height: 2,
                        ),
                      ),
                      TextSpan(
                        text: ' Policy.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
