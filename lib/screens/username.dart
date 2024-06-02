// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_constructors_in_immutables, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/born.dart';

class Username extends StatefulWidget {
  TextEditingController _usernameController = TextEditingController();
  FocusNode _usernameFocusNode = FocusNode();
  bool _isButtonDisabled = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_updateButtonState);
    _usernameFocusNode.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final username = _usernameController.text.trim();
    setState(() {
      _isButtonDisabled = username.isEmpty || username.length < 4;
    });
  }

  void _updateUsername() {
    final username = _usernameController.text.trim();
    if (!_isButtonDisabled) {
      setState(() {
        widget.currentUser.username = username;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BirthDay(
              widget.currentUser,
            ),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _usernameFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToInputField() {
    final double yOffset = MediaQuery.of(context).viewInsets.bottom;
    final double inputFieldOffset = _usernameFocusNode.offset.dy - yOffset;
    _scrollController.animateTo(
      inputFieldOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Prevents the keyboard from covering the button
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
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(left: 77, right: 76, top: 20),
                child: Text(
                  'What’s your First name? ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600,
                    height:
                        1.19, // line-height of 38px can be achieved by setting the height to 38 / 32 = 1.19
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40,
                bottom: 36,
              ),
              child: SvgPicture.asset(widget.currentUser.gender.contains('Male')
                  ? 'assets/image/maleColor.svg'
                  : 'assets/image/femaleColor.svg'),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.only(left: 25, right: 25),
              height: 56,
              child: TextField(
                controller: _usernameController,
                focusNode: _usernameFocusNode,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(
                      color: Color(0xFF79747E),
                    ), // Set the color of the border when focused
                  ),
                  labelText: 'First Name',
                ),
                onTap: () {
                  _scrollToInputField();
                },
              ),
            ),
            SizedBox(
                height:
                    20), // Add some space between the input field and the confirm button
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 362,
                margin: EdgeInsets.only(left: 25, right: 25),
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      _isButtonDisabled ? Colors.grey : Color(0xFF31C48D),
                    ),
                  ),
                  onPressed: _isButtonDisabled ? null : _updateUsername,
                  child: Text(
                    'Confirm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height:
                          1.25, // line height in Flutter is controlled using the height property
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
