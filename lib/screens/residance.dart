// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_element, prefer_final_fields, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/languageUser.dart';
import 'package:mahram_optimise_v01/services/authService.dart';

class UserAddressWidget extends StatefulWidget {
  final UsersEntity currentUser;

  UserAddressWidget(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<UserAddressWidget> createState() => _UserAddressWidgetState();
}

class _UserAddressWidgetState extends State<UserAddressWidget> {
  TextEditingController _addressController = TextEditingController();
  FocusNode _addressFocusNode = FocusNode();
  ScrollController _scrollController = ScrollController();
  AuthService _authService = AuthService();
  LatLng? userLocation;
  TextEditingController controller = TextEditingController();
  late bool _isValidAddress = false;
  late bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _addressController.addListener(_updateButtonState);
    _addressFocusNode.addListener(_updateButtonState);
    if (widget.currentUser.adress.isEmpty) {
      setState(() {
        _isButtonDisabled = true;
        _isValidAddress = false;
      });
    }
  }

  void _updateButtonState() {
    final address = _addressController.text.trim();
    setState(() {
      _isButtonDisabled =
          address.isEmpty || address.length < 4 || !_isValidAddress;
    });
  }

  void _updateAddress() {
    final address = _addressController.text.trim();
    if (!_isButtonDisabled) {
      setState(() {
        widget.currentUser.adress = address;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LanguageSelect(
              widget.currentUser,
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _addressFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevents the keyboard from covering the button
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        titleSpacing: 120,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/progresstwo.svg',
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          width: currentWidth,
          height: currentHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 40,
                        left: 70,
                        right: 70,
                        top: 40,
                      ),
                      child: Text(
                        'Votre Adresse ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Icon(
                            Icons.location_on_outlined,
                            size: 80,
                            color: Color(0xFF31C48D),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: 362,
                      height: 56,
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: _addressController,
                        googleAPIKey: "AIzaSyARz6ZgWe7M2oSKMq9S4cjP__0JApYjbkQ",
                        inputDecoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.my_location_outlined,
                              color: Color(0xFF31C48D).withOpacity(0.7),
                            ),
                            onPressed: () async {
                              _getUserLocation();
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          labelText: 'Votre adresse Postale',
                        ),
                        getPlaceDetailWithLatLng: (Prediction prediction) {
                          print(
                            "placeDetails" + prediction.lng.toString(),
                          );
                        },
                        itmClick: (Prediction prediction) {
                          _addressController.text = prediction.description!;
                          _addressController.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                                offset: prediction.description!.length),
                          );
                          setState(() {
                            _isValidAddress = true; // Address is valid
                            widget.currentUser.adress = prediction.description!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: 362,
                      height: 56,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            _isButtonDisabled ? Colors.grey : Color(0xFF31C48D),
                          ),
                        ),
                        onPressed: _isButtonDisabled ? null : _updateAddress,
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollToInputField() {
    final double yOffset = MediaQuery.of(context).viewInsets.bottom;
    final double inputFieldOffset = _addressFocusNode.offset.dy - yOffset;
    _scrollController.animateTo(
      inputFieldOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _getUserLocation() async {
    String address = await _authService.getUserLocation(widget.currentUser);

    setState(() {
      _addressController.text = address;
      widget.currentUser.pays = _addressController.text;
      _isButtonDisabled = false;
    });
  }
}
