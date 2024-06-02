// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_cast, unnecessary_string_interpolations, file_names

import 'package:flutter/material.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/settings.dart';

class ProfileDetails extends StatefulWidget {
  final UsersEntity currentUser;

  ProfileDetails(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.currentUser.photoList)
                        as ImageProvider<Object>),
                Positioned(
                  left: 70,
                  top: 70,
                  child: Transform.scale(
                    scale: 0.6,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(5),
                      child: Transform.scale(
                        scale: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Actions lorsque l'icône de croix est cliquée
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.currentUser.username}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.verified,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(108, 216, 203, 203),
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(left: 19, right: 19, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 19, top: 14),
                        child: Text(
                          'Verify your Id',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 14),
                        child: Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(
                    margin: EdgeInsets.only(left: 19),
                    child: Text(
                      'Duis interdum bibendum sed a orci mauris quis senectus. Arcu maecenas interdum id iaculis ultrices mi magna.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF79747E)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 25,
                    margin: EdgeInsets.only(left: 19, bottom: 17),
                    child: SizedBox(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF31C48D),
                          ),
                        ),
                        child: Text(
                          'Get Id verification',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Divider(
              height: 10,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileSettingsPage(
                                widget.currentUser,
                              )),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 25),
                    child: Text(
                      '\tSettings\t',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 15, 15, 15),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileSettingsPage(
                                widget.currentUser,
                              )),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        // Navigate to the desired widget
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileSettingsPage(
                              widget.currentUser,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text('\tHelp center\t',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 15, 15, 15),
                      )),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.help_center),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text('\tInvite friends\t',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 15, 15, 15),
                      )),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.people),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            Divider(
              height: 10,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
