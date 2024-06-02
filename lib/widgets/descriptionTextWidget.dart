// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String description;

  DescriptionTextWidget(this.description, {Key? key}) : super(key: key);

  @override
  State<DescriptionTextWidget> createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        widget.description,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    );
  }
}
