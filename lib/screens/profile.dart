// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_full_hex_values_for_flutter_colors, sized_box_for_whitespace, avoid_unnecessary_containers, must_be_immutable, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/homeProfile.dart';
import 'package:mahram_optimise_v01/services/authService.dart';

class Profile extends StatefulWidget {
  final UsersEntity currentUser;
  String vcode;
  Profile(this.currentUser, this.vcode, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

bool sendCode = false;
String resentCode = '';
AuthService _authService = AuthService();

class _ProfileState extends State<Profile> {
  final List<FocusNode> codeFocusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );

  List<TextEditingController> codeControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  void resendCode() async {
    AuthService _authService = AuthService();
    String code = _authService.generateVerificationCode();

    _authService.sendVerificationCode(widget.currentUser.mahramMail, code);

    setState(() {
      widget.vcode = code;
      resentCode = code;
      sendCode = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.vcode == null) {
      resendCode();
    }
  }

  navigatetoApp() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeProfile(widget.currentUser),
      ),
    );
  }

  @override
  void dispose() {
    for (var focusNode in codeFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
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
                      'Verification code ${widget.vcode}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 45),
                    Text(
                      'Please enter the 6-digit code sent to ${widget.currentUser.email}',
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
                          widget.currentUser.mahramMail,
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
                        onChanged: (value) {
                          if (value.isEmpty && index > 0) {
                            // Move focus to the previous code input field
                            FocusScope.of(context)
                                .requestFocus(codeFocusNodes[index - 1]);
                          } else if (value.isNotEmpty && index < 5) {
                            // Move focus to the next code input field
                            FocusScope.of(context)
                                .requestFocus(codeFocusNodes[index + 1]);
                          }
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        textAlign: TextAlign.center,
                        maxLength: 6,
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
                  onPressed: () async {
                    String enteredCode = codeControllers
                        .map((controller) => controller.text)
                        .join('');

                    if (enteredCode == widget.vcode) {
                      try {
                        String mahramMail = widget.currentUser.mahramMail;

                        /////////////////////////////////////////////////
                        String userId =
                            widget.currentUser.userCredential!.user!.uid;
                        if (userId != null) {
                          Map<String, dynamic> newData = {
                            'mahramValide': true,
                          };
                          _authService.updateUserInfo(userId, newData);

                          /////////////////////////////////////////////////

                          await _authService.createParentAccount(
                            mahramMail,
                            widget.currentUser,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeProfile(
                                widget.currentUser,
                              ),
                            ),
                          );
                        } else {
                          print('User ID is null');
                        }
                      } catch (e) {
                        print('====> $e');
                      }
                    } else if (enteredCode == resentCode) {
                      try {
                        String mahramMail = widget.currentUser.mahramMail;

                        /////////////////////////////////////////////////
                        String userId =
                            widget.currentUser.userCredential!.user!.uid;
                        if (userId != null) {
                          Map<String, dynamic> newData = {
                            'mahramValide': true,
                          };
                          _authService.updateUserInfo(userId, newData);

                          /////////////////////////////////////////////////

                          await _authService.createParentAccount(
                            mahramMail,
                            widget.currentUser,
                          );
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeProfile(widget.currentUser),
                            ),
                          );
                        } else {
                          print('User ID is null');
                        }
                      } catch (e) {
                        print('====> $e');
                      }
                    } else {
                      // Code does not match
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text(
                            'Verification code does not match. Please try again.',
                          ),
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
                    'Enter Code ${widget.currentUser.userCredential!.user!.email}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  resendCode();
                },
                child: Container(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Did not receive a code?  ',
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
                              color:
                                  sendCode == true ? Colors.grey : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
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
