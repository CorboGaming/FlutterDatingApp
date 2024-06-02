// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_cast, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/kidsStatusSelect.dart';

class StatusUserSelect extends StatefulWidget {
  final UsersEntity currentUser;
  StatusUserSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<StatusUserSelect> createState() => _StatusUserSelectState();
}

class _StatusUserSelectState extends State<StatusUserSelect> {
  List<String> statusList = ['celibataire', 'mariée', 'divorcé'];
  String? selectedStatus;

  void handleNextButton() {
    if (selectedStatus == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please choose a status.'),
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
        widget.currentUser.statutMarital = selectedStatus!;
      });
      print(widget.currentUser.statutMarital);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KidsStatusSelect(
            widget.currentUser,
          ),
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
              'assets/image/statusProgress.svg',
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 77),
            child: Text(
              'Select your status',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: statusList.length,
              itemBuilder: (context, index) {
                final status = statusList[index];
                return RadioListTile(
                  title: Text(status),
                  value: status,
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value as String?;
                    });
                  },
                );
              },
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
    );
  }
}
