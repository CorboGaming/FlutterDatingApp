// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ReligiosityWidget extends StatefulWidget {
  final String pratique;
  final String dresscode;

  ReligiosityWidget(this.pratique, this.dresscode, {Key? key})
      : super(key: key);

  @override
  State<ReligiosityWidget> createState() => _ReligiosityWidgetState();
}

class _ReligiosityWidgetState extends State<ReligiosityWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Wrap(
        spacing: 50,
        runSpacing: 20,
        children: [
          buildCustomContainer(
            widget.pratique,
            Icons.self_improvement_outlined,
          ),
          buildCustomContainer(
            widget.dresscode,
            Icons.bedtime_outlined,
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
