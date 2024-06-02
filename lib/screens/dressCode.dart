import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/userHobies.dart';

class DressCodeSelect extends StatefulWidget {
  final UsersEntity currentUser;

  DressCodeSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<DressCodeSelect> createState() => _DressCodeSelectState();
}

class _DressCodeSelectState extends State<DressCodeSelect> {
  String? selectedDressCode;

  void handleNextButton() {
    if (selectedDressCode == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please choose a dress code.'),
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
        widget.currentUser.dressCode = selectedDressCode!;
        print(widget.currentUser.dressCode);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserHobbies(widget.currentUser),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dressCodeList = [
      'Casual',
      'Business Casual',
      'Formal',
      'Traditional',
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
              'assets/image/dressCodeProgress.svg',
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
              'What is your dress code?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dressCodeList.length,
              itemBuilder: (context, index) {
                final dressCode = dressCodeList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDressCode = dressCode;
                    });
                  },
                  child: ListTile(
                    title: Text(dressCode),
                    leading: Radio<String>(
                      value: dressCode,
                      groupValue: selectedDressCode,
                      onChanged: (String? value) {
                        setState(() {
                          selectedDressCode = value;
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
