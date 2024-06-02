// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/gender.dart';

class Survey extends StatefulWidget {
  final UsersEntity currentUser;
  Survey(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  UsersEntity currentUser = UsersEntity();

  @override
  Widget build(BuildContext context) {
    final currentWidht = MediaQuery.of(context).size.width;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 77, right: 76),
                  child: Text(
                    'Salam and Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                      height:
                          1.19, // line-height of 38px can be achieved by setting the height to 38 / 32 = 1.19
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  child: Text(
                    'Looks like you\'re new here?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18.0,
                      color: Color.fromARGB(146, 89, 89,
                          89), // Use the Color class with the hexadecimal value

                      fontWeight: FontWeight.w400,
                      height:
                          1.19, // line-height of 19px can be achieved by setting the height to 19 / 16 = 1.19
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                if (widget.currentUser.userCredential?.user?.email != null &&
                    widget.currentUser.userCredential!.user!.email!
                        .contains(''))
                  Container(
                    margin: EdgeInsets.only(left: 60, right: 60, top: 5),
                    child: Text(
                      widget.currentUser.userCredential!.user!.email.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        height:
                            1.26, // line-height of 19px can be achieved by setting the height to 19 / 16 = 1.26
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                SizedBox(height: 32),
                SvgPicture.asset(
                  'assets/image/welcom.svg',
                  width: 150,
                  height: 200,
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 45, right: 45, top: 30, bottom: 50),
                  child: Text(
                    'Tell us about yourself and Inshallah we will find you a right soulmate',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24.0,
                      color: Color(0xFf595959).withOpacity(0.7),
                      fontWeight: FontWeight.w300,
                      height:
                          1.17, // Calculated based on the line-height (28px) and font-size (24px): 28 / 24 = 1.17
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 60,
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Gender(widget.currentUser),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF31C48D)),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height:
                          1.25, // Calculated based on the line-height (20px) and font-size (16px): 20 / 16 = 1.25
                      letterSpacing: 0.1,
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
