import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/dressCode.dart';

class ReligionStatusSelect extends StatefulWidget {
  final UsersEntity currentUser;

  ReligionStatusSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<ReligionStatusSelect> createState() => _ReligionStatusSelectState();
}

class _ReligionStatusSelectState extends State<ReligionStatusSelect> {
  String? selectedReligionStatus;

  void handleNextButton() {
    if (selectedReligionStatus == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please choose a religion status.'),
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
        widget.currentUser.pratiqueReligieuse = selectedReligionStatus!;
        print(widget.currentUser.pratiqueReligieuse);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DressCodeSelect(widget.currentUser),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final religionStatusList = [
      'Pratiquant',
      'tres Pratiquant',
      'modérément Pratiquant',
      'pas pratiquant',
      'Other',
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
              'assets/image/religionProgress.svg',
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
              'What is your religion status?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: religionStatusList.length,
              itemBuilder: (context, index) {
                final religionStatus = religionStatusList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedReligionStatus = religionStatus;
                    });
                  },
                  child: ListTile(
                    title: Text(religionStatus),
                    leading: Radio<String>(
                      value: religionStatus,
                      groupValue: selectedReligionStatus,
                      onChanged: (String? value) {
                        setState(() {
                          selectedReligionStatus = value;
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
