// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EducationAndCarrerWidget extends StatefulWidget {
  final String langue;
  final String education;

  EducationAndCarrerWidget(this.langue, this.education, {Key? key})
      : super(key: key);

  @override
  State<EducationAndCarrerWidget> createState() =>
      _EducationAndCarrerWidgetState();
}

class _EducationAndCarrerWidgetState extends State<EducationAndCarrerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Wrap(
        spacing: 50,
        runSpacing: 20,
        children: [
          buildCustomContainer(
            widget.langue,
            Icons.public_outlined,
          ),
          buildCustomContainer(
            widget.education,
            Icons.g_translate_outlined,
          ),
        ],
      ),
    );
  }
}

Container buildCustomContainer(String taille, IconData iconData) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.withOpacity(0.1),
    ),
    child: Padding(
      padding: EdgeInsets.only(
        right: 20,
        left: 15,
        top: 5,
        bottom: 5,
      ),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Row(
          children: [
            Icon(
              iconData,
              size: 18,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              taille,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
