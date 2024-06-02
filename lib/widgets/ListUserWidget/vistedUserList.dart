// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class VisitedUserList extends StatefulWidget {
  const VisitedUserList({super.key});

  @override
  State<VisitedUserList> createState() => _VisitedUserListState();
}

class _VisitedUserListState extends State<VisitedUserList> {
  List<UserProfile> users = [
    UserProfile(
      name: 'Cloe ',
      age: 25,
      location: 'New York',
      imageUrl: 'assets/image/profile.jpg',
    ),
    UserProfile(
      name: 'Melanie',
      age: 30,
      location: 'London',
      imageUrl: 'assets/image/photoprofile.jpg',
    ),
    // Add more user profiles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Number of columns in the grid
      padding: const EdgeInsets.all(8.0),
      children: users.map((user) => buildUserProfile(user)).toList(),
    );
  }

  Widget buildUserProfile(UserProfile user) {
    return Card(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AspectRatio(
            aspectRatio:
                1.3, // Adjust the aspect ratio as needed for increased height
            child: Image.asset(
              user.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black.withOpacity(0.5),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user.name}, ${user.age}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFF31C48D),
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '19 Kilometers away , ${user.location}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfile {
  final String name;
  final int age;
  final String location;
  final String imageUrl;

  UserProfile({
    required this.name,
    required this.age,
    required this.location,
    required this.imageUrl,
  });
}
