// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names, avoid_print, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/jobSelect.dart';

class EducationLevelSelect extends StatefulWidget {
  final UsersEntity currentUser;

  EducationLevelSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<EducationLevelSelect> createState() => _EducationLevelSelectState();
}

class _EducationLevelSelectState extends State<EducationLevelSelect> {
  String? selectedEducationLevel;

  void handleNextButton() {
    if (selectedEducationLevel == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please choose an education level.'),
            actions: [
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
    } else {
      setState(() {
        widget.currentUser.education = selectedEducationLevel!;
      });
      print(widget.currentUser.education);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JobSelect(widget.currentUser),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final educationLevels = [
      'High School',
      'Bachelor\'s Degree',
      'Master\'s Degree',
      'Ph.D.'
    ];

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
              'assets/image/educationProgress.svg',
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 77),
            child: Text(
              'What is your education level?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: educationLevels.length,
              itemBuilder: (context, index) {
                final educationLevel = educationLevels[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEducationLevel = educationLevel;
                    });
                  },
                  child: ListTile(
                    title: Text(educationLevel),
                    leading: Radio<String>(
                      value: educationLevel,
                      groupValue: selectedEducationLevel,
                      onChanged: (String? value) {
                        setState(() {
                          selectedEducationLevel = value;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            width: 362,
            height: 56,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF31C48D)),
              ),
              onPressed: handleNextButton,
              child: Text(
                'Next${widget.currentUser.userCredential?.user?.email}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
