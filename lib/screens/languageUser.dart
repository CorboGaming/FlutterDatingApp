// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/statusUser.dart';

class LanguageSelect extends StatefulWidget {
  final UsersEntity currentUser;
  LanguageSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<LanguageSelect> createState() => _LanguageSelectState();
}

class _LanguageSelectState extends State<LanguageSelect> {
  List<String> languageList = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese',
    'Hindi',
    'Russian',
    'Portuguese',
    'Indonesian',
    'Urdu',
    'Japanese ',
    'Turkish ',
  ];
  List<String> selectedLanguages = [];
  List<String> filteredLanguageList = [];

  @override
  void initState() {
    super.initState();
    filteredLanguageList = languageList;
  }

  void filterLanguages(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredLanguageList = languageList
            .where((language) =>
                language.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredLanguageList = languageList;
      }
    });
  }

  void handleNextButton() {
    if (selectedLanguages.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please choose at least one language.'),
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
    } else if (selectedLanguages.length > 5) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select up to 5 languages.'),
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
      String selectedLanguagesString = selectedLanguages.join(', ');
      setState(() {
        widget.currentUser.langues = selectedLanguagesString;
      });
      print('==========================================');
      print(widget.currentUser.langues);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StatusUserSelect(
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
              'assets/image/languageProgress.svg',
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
              'Which languages do you speak?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search languages",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                onChanged: (query) {
                  filterLanguages(query);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLanguageList.length,
              itemBuilder: (context, index) {
                final language = filteredLanguageList[index];
                final isSelected = selectedLanguages.contains(language);
                return ListTile(
                  title: Text(language),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedLanguages.remove(language);
                      } else {
                        selectedLanguages.add(language);
                      }
                    });
                  },
                  trailing: isSelected
                      ? Icon(Icons.check, color: Colors.green)
                      : null,
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
