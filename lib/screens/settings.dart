// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';

class ProfileSettingsPage extends StatefulWidget {
 
  final UsersEntity currentUser;

  ProfileSettingsPage(this.currentUser,  {Key? key})
      : super(key: key);

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool forAndroid = false;
  bool forAndroid1 = false;
  bool forAndroid2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50, bottom: 50),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            Row(
              children: [
                Text('\tEdit email\t',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 15, 15, 15),
                    )),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.edit_square),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => EmailEditPage()),
                      // );
                    },
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('\tEdit phone number\t',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 15, 15, 15),
                    )),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.edit_square),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => PhoneEditPage()),
                      // );
                    },
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Add your filter profile by action
                },
                child: Text('Filter Profile By'),
              ),
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Switch(
                  // thumb color (round icon)
                  activeColor: Colors.white,
                  activeTrackColor: Color.fromARGB(255, 17, 177, 76),
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  splashRadius: 50.0,
                  // boolean variable value
                  value: forAndroid,
                  // changes the state of the switch
                  onChanged: (value) => setState(() => forAndroid = value),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Display Previous Message'),
                Spacer(),
                Switch(
                  // thumb color (round icon)
                  activeColor: Colors.white,
                  activeTrackColor: Color.fromARGB(255, 17, 177, 76),
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  splashRadius: 50.0,
                  // boolean variable value
                  value: forAndroid1,
                  // changes the state of the switch
                  onChanged: (value) => setState(() => forAndroid1 = value),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Add your Account action
                },
                child: Text(
                  'Account',
                  selectionColor: Colors.black,
                ),
              ),
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Language'),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // Add your language action
                  },
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.g_translate),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Purchase'),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // Add your editing credit card number action
                  },
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.credit_card),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Add your take a break action
                },
                child: Text('Take a Break'),
              ),
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Hide Profile'),
                Spacer(),
                Switch(
                  // thumb color (round icon)
                  activeColor: Colors.white,
                  activeTrackColor: Color.fromARGB(255, 17, 177, 76),
                  inactiveThumbColor: Colors.black,
                  inactiveTrackColor: Colors.white,
                  splashRadius: 50.0,
                  // boolean variable value
                  value: forAndroid2,
                  // changes the state of the switch
                  onChanged: (value) => setState(() => forAndroid2 = value),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Log Out'),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      // Add your log out action
                    },
                    icon: Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Delete/Disable Account'),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      // Add your delete/disable account action
                    },
                    icon: Icon(Icons.person_remove_outlined),
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: Color.fromARGB(255, 207, 205, 205),
            ),
          ],
        ),
      ),
    );
  }
}
