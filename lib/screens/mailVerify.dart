// ignore_for_file: prefer_const_constructors, must_be_immutable, library_private_types_in_public_api, use_full_hex_values_for_flutter_colors, sized_box_for_whitespace, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, file_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/verifiedCode.dart';
import 'package:mahram_optimise_v01/services/authService.dart';

class MailVerify extends StatefulWidget {
  final UsersEntity currentUser;
  String verificationcode;
  MailVerify(this.verificationcode, this.currentUser, {Key? key})
      : super(key: key);

  @override
  _MailVerifyState createState() => _MailVerifyState();
}

class _MailVerifyState extends State<MailVerify> {
  String getCode() {
    String code = '';
    for (final controller in codeControllers) {
      code += controller.text;
    }

    return code;
  }

  final List<TextEditingController> codeControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> codeFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (final controller in codeControllers) {
      controller.dispose();
    }
    for (final focusNode in codeFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Add listeners to text controllers to move the focus automatically
    for (int i = 0; i < codeControllers.length; i++) {
      codeControllers[i].addListener(() {
        if (codeControllers[i].text.length == 1 &&
            i < codeControllers.length - 1) {
          codeFocusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  void resetCodeInputs() {
    for (final controller in codeControllers) {
      controller.clear();
    }
    codeFocusNodes[0].requestFocus();
  }

  bool codeMatched = false;

  void checkVerificationCode() {
    String receivedCode = getCode();

    if (receivedCode == widget.verificationcode) {
      setState(() {
        codeMatched = true;
      });
    } else {
      setState(() {
        codeMatched = false;
      });
      resetCodeInputs();
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
        titleSpacing: 120,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/image/lastProgress.svg',
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 45, bottom: 45),
                child: Column(
                  children: [
                    Text(
                      'Verification code ${widget.verificationcode}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 45),
                    Text(
                      'Please enter the 6-digit code sent to',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xffb595959),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.currentUser.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Add your code for editing the email here
                          },
                          child: Icon(
                            Icons.edit,
                            size: 16,
                            color: Color(0xFF31C48D),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 41),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffbE2E8F0),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextFormField(
                        controller: codeControllers[index],
                        focusNode: codeFocusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: 362,
                height: 56,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF31C48D)),
                  ),
                  onPressed: () {
                    checkVerificationCode();

                    if (codeMatched) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerifiedCode(
                            widget.currentUser,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text(
                              'Verification code does not match. Please try again.'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Enter Code',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // Add your code for resending the code here
                },
                child: Container(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Did not receive a code? ',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: 'Resend',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AuthService _auth = AuthService();
                                String resentCode =
                                    _auth.generateVerificationCode();
                                _auth.sendVerificationCode(
                                    widget.currentUser.email, resentCode);
                                setState(() {
                                  widget.verificationcode = resentCode;
                                });
                                // Add your code for resending the code here
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
