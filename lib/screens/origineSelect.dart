// ignore_for_file: prefer_const_constructors, file_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/nationality.dart';

class OriginSelect extends StatefulWidget {
  final UsersEntity currentUser;
  OriginSelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<OriginSelect> createState() => _OriginSelectState();
}

class _OriginSelectState extends State<OriginSelect> {
  List<String> originList = [
    'Afghan',
    'Afro-américain',
    'Antillais',
    'Arab',
    'Asiatique',
    'Bangladais',
    'Berbére',
    'Centre Africain',
    "D'afrique de l'est",
    "D'afrique de l'ouest",
    'Egyptien',
    'Européen',
    'Indien',
    'Indonésien',
    'Irakien',
    'Kurde',
    'Latino',
    'Malais',
    'Métis',
    'Nigérian',
    'Palestinien',
    'Somalie',
    'Turc',
    'Nord-américain',
    'Nord-africain',
    'sud-africain',
    'Autre',
  ];
  String selectedOrigins = '';
  List<String> filteredOriginList = [];
  bool istriggered = false;

  @override
  void initState() {
    super.initState();
    istriggered = false;
    filteredOriginList = originList;
  }

  void filterOrigins(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredOriginList = originList
            .where(
                (origin) => origin.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredOriginList = originList;
      }
    });
  }

  void handleNextButton() {
    if (selectedOrigins.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Quelles sont vos origine enthniques?.'),
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
        widget.currentUser.origine = selectedOrigins;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NationalitySelect(widget.currentUser),
          ),
        );
      });
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
              'assets/image/originProgress.svg',
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Quelles sont vos origine enthniques?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
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
                  labelText: "chercher vos origines ethniques...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                onChanged: (query) {
                  filterOrigins(query);
                },
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOriginList.length,
              itemBuilder: (context, index) {
                final origin = filteredOriginList[index];
                final isSelected = selectedOrigins.contains(origin);
                return ListTile(
                  title: Text(
                    origin,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
                  ),
                  trailing: isSelected
                      ? Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.check,
                              size: 13,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedOrigins = '';
                      } else {
                        selectedOrigins = origin;
                        handleNextButton();
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
