// ignore_for_file: prefer_const_constructors, avoid_print, file_names, prefer_const_constructors_in_immutables, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/SizeUser.dart';

class KidsStatusSelect extends StatefulWidget {
  final UsersEntity currentUser;
  KidsStatusSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<KidsStatusSelect> createState() => _KidsStatusSelectState();
}

class _KidsStatusSelectState extends State<KidsStatusSelect> {
  bool? hasKids;

  void handleNextButton() {
    if (hasKids == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select if you have kids or not.'),
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
    } else {
      setState(() {
        widget.currentUser.enfants = hasKids!;
      });
      print(widget.currentUser.enfants);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SizeUser(widget.currentUser),
        ),
      );

      // Navigate to the next screen or perform other actions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        titleSpacing: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/kidsProgress.svg',
            ),
          ],
        ),
      ),
      body: Center(
        // Wrap the Column with Center widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 77),
              child: Text(
                'Do you have kids?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  RadioListTile(
                    title: Text('Yes'),
                    value: true,
                    groupValue: hasKids,
                    onChanged: (value) {
                      setState(() {
                        hasKids = value as bool?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('No'),
                    value: false,
                    groupValue: hasKids,
                    onChanged: (value) {
                      setState(() {
                        hasKids = value as bool?;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              width: 362,
              height: 56,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF31C48D)),
                ),
                onPressed: handleNextButton,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
