// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/homeProfile.dart';
import 'package:mahram_optimise_v01/services/authService.dart';
import 'package:mahram_optimise_v01/screens/profile.dart' as profile;

class MorePhotos extends StatefulWidget {
  final UsersEntity currentUser;

  MorePhotos(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<MorePhotos> createState() => _MorePhotosState();
}

class _MorePhotosState extends State<MorePhotos> {
  File? _selectedImage;
  String? selectedImagePath;

  AuthService _authService = AuthService();

  Future<void> _selectPhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      // Call _uploadPhoto method directly
      await _uploadPhoto();
    }
  }

  Future<void> _uploadPhoto() async {
    if (_selectedImage != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(
              'profile_images/${widget.currentUser.userCredential!.user!.uid}')
          .child('collection.jpg');
      await storageRef.putFile(_selectedImage!);
      final downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        widget.currentUser.photoList = downloadUrl;
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
              'assets/image/mahramProgress.svg',
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 21,
              ),
              child: Text(
                'Add more photos',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _selectPhoto,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    image: _selectedImage != null
                        ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  margin: EdgeInsets.all(
                    20,
                  ),
                  width: 150,
                  height: 200,
                  child: _selectedImage == null
                      ? DottedBorder(
                          borderType: BorderType.RRect,
                          strokeWidth: 1,
                          // dashPattern: [8, 8],
                          child: Center(
                            child: Icon(
                              Icons.add_circle_outline,
                              size: 30,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        )
                      : null,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      'lorem12 ',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
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
              onPressed: () async {
                await _uploadPhoto();

                if (widget.currentUser.gender.contains('Male')) {
                  await _authService.addUserToFirestore(widget.currentUser,
                      widget.currentUser.userCredential as UserCredential);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeProfile(
                        widget.currentUser,
                      ),
                    ),
                  );
                } else if (widget.currentUser.gender.contains('Female')) {
                  await _authService.addUserToFirestore(widget.currentUser,
                      widget.currentUser.userCredential as UserCredential);
                  String vCode = _authService.generateVerificationCode();
                  _authService.sendVerificationCode(
                    widget.currentUser.mahramMail,
                    vCode,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => profile.Profile(
                        widget.currentUser,
                        vCode,
                      ),
                    ),
                  );
                }
              },
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
