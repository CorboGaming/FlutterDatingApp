// ignore_for_file: avoid_print, prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Country {
  final String name;

  Country({required this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
    );
  }
}

class CountrySelectionScreen extends StatefulWidget {
  @override
  _CountrySelectionScreenState createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  List<Country> countries = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/jsonFiles/countries.json');
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      setState(() {
        countries = jsonData.map((item) => Country.fromJson(item)).toList();
      });
    } catch (e) {
      print('Error loading countries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country'),
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];
          return ListTile(
            title: Text(country.name),
            onTap: () {
              // Handle country selection
              print('Selected country: ${country.name}');
            },
          );
        },
      ),
    );
  }
}
