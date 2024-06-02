// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, file_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/origineSelect.dart';

class MahramInfo extends StatefulWidget {
  final UsersEntity currentUser;

  MahramInfo(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<MahramInfo> createState() => _MahramInfoState();
}

class _MahramInfoState extends State<MahramInfo> {
  String mahramName = '';
  String mahramLastName = '';
  String mahramPhone = '';
  String mahramEmail = '';
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isPhoneValid(String phone) {
    final phoneRegex = RegExp(r'^\+?[\d-]+(?:[\d-]+){1}$');
    return phoneRegex.hasMatch(phone);
  }

  bool isNameValid(String name) {
    return name.isNotEmpty && name.length >= 4;
  }

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
        centerTitle: true,
        titleSpacing: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/mahramProgress.svg',
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final currentHight = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        'Fill your Mahram Informations?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      child: Transform.scale(
                        scale: 0.9,
                        child: SvgPicture.asset('assets/image/mahram.svg'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: 362,
                      height: 56,
                      child: TextField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: 362,
                      height: 56,
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          labelText: 'Phone Number',
                        ),
                        initialCountryCode: 'FR',
                        keyboardType: TextInputType.number,
                        onChanged: (phone) {
                          setState(() {
                            mahramPhone = phone.completeNumber;
                          });
                        },
                        onCountryChanged: (phone) {},
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: 362,
                      height: 56,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    SizedBox(height: currentHight <= 800 ? 10 : 180),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      width: 362,
                      height: 56,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF31C48D)),
                          ),
                          onPressed: () {
                            String email = emailController.text;
                            bool isValidEmail = isEmailValid(email);
                            bool isValidPhone = isPhoneValid(mahramPhone);

                            if (!isValidEmail) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Invalid Email'),
                                    content: Text(
                                        'Please enter a valid email address.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (!isValidPhone) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Invalid Phone Number'),
                                    content: Text(
                                        'Please enter a valid phone number.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              setState(() {
                                mahramName = firstNameController.text;
                                mahramLastName = lastNameController.text;
                                mahramEmail = email;
                              });

                              widget.currentUser.mahramNom = mahramName;
                              widget.currentUser.mahramPrenom = mahramLastName;
                              widget.currentUser.mahramMail = mahramEmail;
                              widget.currentUser.mahramTel = mahramPhone;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OriginSelect(widget.currentUser),
                                ),
                              );
                            }
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
