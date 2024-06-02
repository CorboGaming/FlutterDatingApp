// ignore_for_file: prefer_const_constructors, unnecessary_cast, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/residance.dart';

class NationalitySelect extends StatefulWidget {
  final UsersEntity currentUser;

  NationalitySelect(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<NationalitySelect> createState() => _NationalitySelectState();
}

class _NationalitySelectState extends State<NationalitySelect> {
  List<String> nationalityList = [];
  String? selectedNationality;
  List<String> filteredNationalityList = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    final String countriesJson =
        await rootBundle.loadString('assets/jsonFiles/countries.json');
    final List<dynamic> countriesData = json.decode(countriesJson);

    final excludedCountries = [
      'CountryA',
      'CountryB'
    ]; // Add the countries you want to exclude to this list

    List<String> countries = countriesData
        .where((data) => !excludedCountries.contains(data['name']))
        .map((data) => data['name'] as String)
        .toList();

    countries.sort(); // Sort the countries alphabetically

    setState(() {
      nationalityList = countries;
      filteredNationalityList = nationalityList;
    });
  }

  void filterNationalities(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredNationalityList = nationalityList
            .where((nationality) =>
                nationality.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredNationalityList = nationalityList;
      }
    });
  }

  void handleNextButton() {
    if (selectedNationality == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please choose a nationality.'),
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
        widget.currentUser.nationality = selectedNationality!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserAddressWidget(
              widget.currentUser,
            ),
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
              'assets/image/nationalityProgress.svg',
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
              'What’s your nationality? ',
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
                  labelText: "Search nationalities",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
                onChanged: (query) {
                  filterNationalities(query);
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredNationalityList.length,
              itemBuilder: (context, index) {
                final nationality = filteredNationalityList[index];
                return ListTile(
                  title: Text(nationality),
                  onTap: () {
                    setState(() {
                      selectedNationality = nationality;
                      handleNextButton();
                    });
                  },
                  trailing: selectedNationality == nationality
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
                );
              },
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
