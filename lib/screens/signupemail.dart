// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/signinpassword.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _email = TextEditingController();
  final UsersEntity user = UsersEntity();

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
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 50,
                  bottom: 25,
                ),
                child: Text(
                  'Enter your email address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 15, 15, 15)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(25),
                child: Text(
                  'Put your email to send you a code to verify your identity',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.all(25),
                width: 362,
                height: 56,
                child: TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
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
                      user.email = _email.text;
                    });
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInPassword(user)));
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
