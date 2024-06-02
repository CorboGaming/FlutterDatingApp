// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AboutMeWidget extends StatefulWidget {
  final String taille;
  final String statusMaritial;
  final bool enfants;

  AboutMeWidget(this.taille, this.statusMaritial, this.enfants, {Key? key})
      : super(key: key);

  @override
  State<AboutMeWidget> createState() => _AboutMeWidgetState();
}

class _AboutMeWidgetState extends State<AboutMeWidget> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 25),
      child: Wrap(
        spacing: 10,
        runSpacing: 20,
        children: [
          buildCustomContainer(
            widget.taille,
            Icons.height,
          ),
          buildCustomContainer(
            widget.statusMaritial,
            Icons.face_6_outlined,
          ),
          buildCustomContainer(
            widget.enfants ? 'jai des enfans' : 'jai pas denfant',
            Icons.work_outline,
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
