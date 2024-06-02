// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_final_fields, avoid_print, library_private_types_in_public_api, prefer_const_constructors_in_immutables, unnecessary_null_comparison, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/homeProfile.dart';
import 'package:mahram_optimise_v01/screens/loginPage.dart';
import 'package:mahram_optimise_v01/screens/mahramWidget.dart';
import 'package:mahram_optimise_v01/screens/profile.dart';
import 'package:mahram_optimise_v01/screens/survey.dart';
import 'package:mahram_optimise_v01/services/authService.dart';

class SignInPassword extends StatefulWidget {
  final UsersEntity currentUser;

  SignInPassword(this.currentUser, {Key? key}) : super(key: key);

  @override
  _SignInPasswordState createState() => _SignInPasswordState();
}

class _SignInPasswordState extends State<SignInPassword> {
  bool showPassword = false; // Initially set to false to hide the password
  final _password = TextEditingController();
  AuthService _authService = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 50,
                  bottom: 25,
                ),
                child: Text(
                  'Enter your Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 15, 15, 15),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.all(45),
                child: Text(
                  'Put your secret password to login to your personal account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.all(25),
                width: 362,
                height: 56,
                child: TextField(
                  controller: _password,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: 362,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 49, 196, 141),
                  ),
                  onPressed: () async {
                    setState(() {
                      widget.currentUser.password = _password.text;
                    });
                    String password = widget.currentUser.password;
                    String email = widget.currentUser.email;

                    UserCredential? userCredential = await _auth
                        .signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    )
                        .catchError((error) async {
                      UserCredential? newuser = await _auth
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      )
                          .then((newuser) {
                        UsersEntity userInstance = UsersEntity();
                        setState(() {
                          userInstance.userCredential = newuser;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Survey(userInstance),
                          ),
                        );
                        return null;
                      });
                    });

                    if (userCredential != null) {
                      print('=====================> $userCredential');
                      String email = userCredential.user!.email as String;
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
                                builder: (context) =>
                                    HomeProfile(widget.currentUser),
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
                                  builder: (context) =>
                                      HomeProfile(widget.currentUser),
                                ),
                              );
                            } else if (checkValidationMahram == false) {
                              setState(() {
                                user.userCredential = userCredential;
                              });
                              String vcode =
                                  await _authService.generateVerificationCode();

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
                      }
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Already have an account?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 49, 196, 141),
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
