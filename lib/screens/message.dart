// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:ui';

import 'package:flutter/material.dart';

class Profile {
  final String imagePath;
  final String name;
  final int age;
  final String location;
  final String bio;
  bool isBlurred;

  Profile({
    required this.imagePath,
    required this.name,
    required this.age,
    required this.location,
    required this.bio,
    this.isBlurred = true,
  });
}

class Match {
  late String playerName;
  late String profilePhoto;
  bool isBlurred;

  Match(this.playerName, this.profilePhoto, {this.isBlurred = true});
}

class Discussion {
  final String name;
  final String message;
  final String profilePhoto;
  final int newMessageCount;
  final String sendTime;

  Discussion(
    this.name,
    this.message,
    this.profilePhoto,
    this.newMessageCount,
    this.sendTime,
  );
}

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final List<Match> matches = [
    Match('John Doe', 'assets/image/photoprofile.jpg'),
    Match('Jane Smith', 'assets/image/femme.png'),
    Match('David Johnson', 'assets/image/profile.jpg'),
  ];

  final List<Discussion> discussions = [
    Discussion(
      'John Doe',
      'Okay',
      'assets/image/photoprofile.jpg',
      2,
      '10:00 AM',
    ),
    Discussion(
      'Jane Smith',
      'Salam',
      'assets/image/profile.jpg',
      0,
      '11:30 AM',
    ),
    Discussion(
      'David Johnson',
      'Salam',
      'assets/image/femme.png',
      5,
      '1:45 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Recent Matches',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: matches.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Handle match item click
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Match Details'),
                          content: Text(matches[index].playerName),
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
                  },
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage:
                                AssetImage(matches[index].profilePhoto),
                          ),
                          Visibility(
                            visible: matches[index].isBlurred,
                            child: ClipOval(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: matches[index].isBlurred
                                ? Icon(
                                    Icons.lock,
                                    size: 24,
                                    color: Colors.white,
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 60,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: discussions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage(discussions[index].profilePhoto),
                    ),
                    title: Row(
                      children: [
                        Text(
                          discussions[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          discussions[index].sendTime,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(discussions[index].message),
                        Spacer(),
                        Text('${discussions[index].newMessageCount} '),
                      ],
                    ),
                    onTap: () {
                      // Handle discussion item click
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(discussions[index].name),
                            content: Text(discussions[index].message),
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
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
