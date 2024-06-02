// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use, prefer_const_constructors_in_immutables, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/morePhotos.dart';

class UploadPhoto extends StatefulWidget {
  final UsersEntity currentUser;

  UploadPhoto(this.currentUser, {Key? key}) : super(key: key);

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  File? _selectedImage;
  bool _isUploading = false;

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
      setState(() {
        _isUploading = true;
      });
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(
              'profile_images/${widget.currentUser.userCredential!.user!.uid}')
          .child('profile.jpg');
      await storageRef.putFile(_selectedImage!);
      final downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        widget.currentUser.profilePhoto = downloadUrl;
      });

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MorePhotos(widget.currentUser),
        ),
      );
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 77),
            child: Text(
              'Upload a photo',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 80,
                  child: _selectedImage != null
                      ? Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(_selectedImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SvgPicture.asset('assets/image/photoSvg.svg'),
                ),
                if (_isUploading)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20),
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
              onPressed: _selectPhoto,
              child: Text(
                'Select Photo${widget.currentUser.userCredential?.user?.email}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
