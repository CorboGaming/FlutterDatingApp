// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/uploadPhoto.dart';

class UserHobbies extends StatefulWidget {
  final UsersEntity currentUser;

  UserHobbies(this.currentUser, {Key? key}) : super(key: key);

  @override
  _UserHobbiesState createState() => _UserHobbiesState();
}

class _UserHobbiesState extends State<UserHobbies> {
  List<String> selectedHobbies = [];
  List<String> hobbies = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchHobbies();
  }

  Future<void> fetchHobbies() async {
    try {
      setState(() {
        isLoading = true; // Show the loading indicator
        hobbies.clear(); // Clear the existing hobbies list
      });

      for (int i = 0; i < 5; i++) {
        // Fetch new hobbies
        final response = await http.get(
          Uri.parse(
              'https://www.boredapi.com/api/activity?type=recreational&participants=1&price=0'),
        );
        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final String hobby = responseData['activity'].toString();

          // Check if the hobby already exists in the list
          if (!hobbies.contains(hobby)) {
            setState(() {
              hobbies.add(hobby);
            });
          }
        } else {
          print('Failed to fetch hobbies. Status code: ${response.statusCode}');
        }
      }
      setState(() {
        isLoading = false; // Hide the loading indicator
      });
    } catch (e) {
      print('Error fetching hobbies: $e');
    }
  }

  void selectHobby(String hobby) {
    setState(() {
      if (selectedHobbies.contains(hobby)) {
        selectedHobbies.remove(hobby);
      } else {
        if (selectedHobbies.length < 5) {
          selectedHobbies.add(hobby);
        } else {
          // Notify the user that only 5 hobbies can be selected
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Maximum Hobbies Reached'),
              content: Text('You can only select up to 5 hobbies.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      }
      widget.currentUser.hobbies = selectedHobbies
          .toList(); // Update the hobbies property of widget.currentUser
      print(widget.currentUser.hobbies);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom: 40,
                  left: 70,
                  right: 70,
                  top: 40,
                ),
                child: Text(
                  'choose 5 of  your hobbies?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              RefreshIndicator(
                onRefresh: fetchHobbies,
                child: isLoading
                    ? CircularProgressIndicator()
                    : Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: hobbies
                            .map((hobby) => GestureDetector(
                                  onTap: () => selectHobby(hobby),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: selectedHobbies.contains(hobby)
                                          ? Colors.black.withOpacity(0.5)
                                          : Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '#$hobby',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: selectedHobbies.contains(hobby)
                                            ? Colors.white
                                            : Colors.blue,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Color(0xFF31C48D).withOpacity(0.3),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.autorenew,
                      color: Color(0xFF31C48D),
                    ),
                    onPressed: fetchHobbies,
                  )),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: 362,
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFF31C48D),
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      widget.currentUser.hobbies = selectedHobbies;
                    });
                    print(widget.currentUser.hobbies);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadPhoto(widget.currentUser),
                      ),
                    );
                  },
                  child: Text(
                    'Confirm${widget.currentUser.userCredential?.user?.email}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
