// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/screens/loginPage.dart';

class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({Key? key});

  @override
  State<MyAnimatedWidget> createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget> {
  @override
  void initState() {
    super.initState();
    // Delay navigation to LoginPage after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 221, 158),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 80,
                spreadRadius: 1,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: SvgPicture.asset('assets/image/logo.svg'),
        ),
      ),
    );
  }
}
