// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/pratiqueReligieuse.dart';

class JobSelect extends StatefulWidget {
  final UsersEntity currentUser;

  JobSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<JobSelect> createState() => _JobSelectState();
}

class _JobSelectState extends State<JobSelect> {
  String? selectedJob;

  void handleNextButton() {
    if (selectedJob == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please choose a job.'),
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
        widget.currentUser.profession = selectedJob!;
        print(widget.currentUser.profession);
      });

      // Navigate to the next screen or perform any necessary actions.
      // Example:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReligionStatusSelect(widget.currentUser),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobList = [
      'Software Engineer',
      'Data Analyst',
      'Product Manager',
      'Graphic Designer',
      'Marketing Specialist',
      'Financial Analyst',
    ];

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
              'assets/image/jobProgress.svg',
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
              'What is your job?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jobList.length,
              itemBuilder: (context, index) {
                final job = jobList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedJob = job;
                    });
                  },
                  child: ListTile(
                    title: Text(job),
                    leading: Radio<String>(
                      value: job,
                      groupValue: selectedJob,
                      onChanged: (String? value) {
                        setState(() {
                          selectedJob = value;
                        });
                      },
                    ),
                  ),
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
                'Next${widget.currentUser.userCredential?.user?.email}',
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
