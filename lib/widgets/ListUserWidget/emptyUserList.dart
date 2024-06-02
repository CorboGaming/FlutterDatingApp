// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyUserList extends StatefulWidget {
  const EmptyUserList({Key? key});

  @override
  State<EmptyUserList> createState() => _EmptyUserListState();
}

class _EmptyUserListState extends State<EmptyUserList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/image/empty.svg', // Replace with your SVG file path
            width: 250,
            height: 250,
          ),
          SizedBox(height: 16),
          Text(
            'Empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'User List is empty',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            width: 253,
            height: 56,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFF31C48D),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.swipe_outlined, color: Colors.white),
              label: Text(
                'Discover',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
