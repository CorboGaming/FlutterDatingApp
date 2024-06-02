// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/educationLevelSelect.dart';

class SizeUser extends StatefulWidget {
  final UsersEntity currentUser;
  SizeUser(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<SizeUser> createState() => _SizeUserState();
}

class _SizeUserState extends State<SizeUser> {
  double? height = 160;
  double? weight = 60;

  void handleNextButton() {
    if (height == null || weight == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select your height and weight.'),
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
        widget.currentUser.taille = height.toString();
        widget.currentUser.poids = weight.toString();
      });
      print(widget.currentUser.taille);
      print(widget.currentUser.poids);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EducationLevelSelect(widget.currentUser),
        ),
      );
      // Navigate to the next screen or perform other actions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        titleSpacing: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/sizeProgress.svg',
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your height and weight',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What is your tall? (CentMiter/cm) ',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF595959)),
                      ),
                      Container(
                        width: double.infinity,
                        child: SliderTheme(
                          data: SliderThemeData(
                            // Set the active color for the Slider

                            // Set the label color for the Slider
                            valueIndicatorTextStyle:
                                TextStyle(color: Colors.white),
                          ),
                          child: Slider(
                            value: height ?? 160,
                            min: 100,
                            max: 220,
                            divisions: 120,
                            label: height.toString(),
                            onChanged: (value) {
                              setState(() {
                                height = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        'What is your tall? (Kilogram/kg) ',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF595959)),
                      ),
                      Container(
                        width: double.infinity,
                        child: SliderTheme(
                          data: SliderThemeData(
                            // Set the active color for the Slider

                            // Set the label color for the Slider
                            valueIndicatorTextStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255)),
                          ),
                          child: Slider(
                            value: weight ?? 60,
                            label: weight.toString(),
                            min: 30,
                            max: 150,
                            divisions: 120,
                            onChanged: (value) {
                              setState(() {
                                weight = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 30,
            right: 30,
            bottom: 20,
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
