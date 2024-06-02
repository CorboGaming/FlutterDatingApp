// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/mailVerify.dart';
import 'package:mahram_optimise_v01/services/authService.dart';

class BirthDay extends StatefulWidget {
  final UsersEntity currentUser;

  BirthDay(this.currentUser, {Key? key}) : super(key: key);
  @override
  _BirthDayState createState() => _BirthDayState();
}

class _BirthDayState extends State<BirthDay> {
  DateTime? selectedDate;
  AuthService _authService = AuthService();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool isAgeValid() {
    if (selectedDate == null) return false;

    final currentDate = DateTime.now();
    var age = currentDate.year - selectedDate!.year;

    if (currentDate.month < selectedDate!.month ||
        (currentDate.month == selectedDate!.month &&
            currentDate.day < selectedDate!.day)) {
      age--;
    }

    return age >= 18;
  }

  @override
  Widget build(BuildContext context) {
    String vcode = _authService.generateVerificationCode();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        titleSpacing: 120,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/progresstwo.svg',
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.only(top: 20, left: 77, right: 76),
              child: Text(
                'When were you born?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              child: SvgPicture.asset(
                widget.currentUser.gender.contains('Male')
                    ? 'assets/image/maleColor.svg'
                    : 'assets/image/femaleColor.svg'
                        'assets/image/birthday.svg',
                height: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              width: 362,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      selectedDate != null
                          ? '${selectedDate!.month}/${selectedDate!.day}/${selectedDate!.year}'
                          : 'MM/D D/YYYY',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.today_outlined,
                        size: 18,
                      ),
                      color: Colors.black,
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    DateTime.now().year - selectedDate!.year >= 18
                        ? 'You’are ${DateTime.now().year - selectedDate!.year} years old  '
                        : '',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height:
                          1.19, // line-height of 19px can be achieved by setting the height to 19 / 16 = 1.19
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 25),
                  width: 362,
                  height: 56,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        isAgeValid() ? Color(0xFF31C48D) : Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      if (isAgeValid()) {
                        // Perform the desired action with the selected date
                        if (selectedDate != null) {
                          // Calculate age
                          final currentDate = DateTime.now();
                          var age = currentDate.year - selectedDate!.year;
                          if (currentDate.month < selectedDate!.month ||
                              (currentDate.month == selectedDate!.month &&
                                  currentDate.day < selectedDate!.day)) {
                            age--;
                          }

                          // Store the age
                          setState(() {
                            widget.currentUser.age = age.toString();
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MailVerify(
                                vcode,
                                widget.currentUser,
                              ),
                            ),
                          );

                          _authService.sendVerificationCode(
                            widget.currentUser.email,
                            vcode.toString(),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Invalid Age'),
                              content: Text('You must be 18 years or older.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
