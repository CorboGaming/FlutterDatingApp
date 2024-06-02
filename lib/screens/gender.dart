// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/username.dart';

class Gender extends StatefulWidget {
  final UsersEntity currentUser;
  Gender(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String? selectedGender;

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
        titleSpacing: 120,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/progressfirst.svg',
            )
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 80), // Adjust the margin as desired
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 77, right: 76),
              child: Text(
                "What's your gender?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 164),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = 'Male';
                      widget.currentUser.gender = selectedGender!;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Username(widget.currentUser),
                        ),
                      );
                    });
                  },
                  child: GenderOption(
                    selectedIcon: 'assets/image/maleColor.svg',
                    unselectedIcon: 'assets/image/male.svg',
                    label: 'Male',
                    isSelected: selectedGender == 'Male',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = 'Female';
                      widget.currentUser.gender = selectedGender!;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Username(widget.currentUser),
                        ),
                      );
                    });
                  },
                  child: GenderOption(
                    selectedIcon: 'assets/image/femaleColor.svg',
                    unselectedIcon: 'assets/image/female.svg',
                    label: 'Female',
                    isSelected: selectedGender == 'Female',
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

class GenderOption extends StatelessWidget {
  final String selectedIcon;
  final String unselectedIcon;
  final String label;
  final bool isSelected;

  const GenderOption({
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.transparent : Colors.transparent,
          ),
          child: Transform.scale(
            scale: 1.6,
            child: SvgPicture.asset(
              isSelected ? selectedIcon : unselectedIcon,
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
