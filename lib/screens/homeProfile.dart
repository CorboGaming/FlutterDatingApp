// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_final_fields, avoid_unnecessary_containers, file_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/screens/listUser.dart';
import 'package:mahram_optimise_v01/screens/message.dart';
import 'package:mahram_optimise_v01/screens/profileDetails.dart';
import 'package:mahram_optimise_v01/screens/swiperProfile/cardSwiperProfile.dart';
import 'package:mahram_optimise_v01/services/authService.dart';

class HomeProfile extends StatefulWidget {
  final UsersEntity currentUser;

  HomeProfile(this.currentUser, {Key? key}) : super(key: key);

  @override
  _HomeProfileState createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  AuthService _authService = AuthService();
  int _currentIndex = 3;
  int _searchIndex = 0;
  late LatLng userLocation;

  @override
  void initState() {
    super.initState();
    // _getUserLocation();
  }

  // Future<void> _getUserLocation() async {
  //   LatLng location = await _authService.getUserLocation(widget.currentUser);
  //   setState(() {
  //     userLocation = location;
  //   });
  // }

  Widget _buildDiscoverContent() {
    // Replace this with your Discover content widget
    return CardSwiperProfile(widget.currentUser);
  }

  Widget _buildListContent() {
    // Replace this with your List content widget
    return ListUserWidget();
  }

  Widget _buildChatContent() {
    // Replace this with your Chat content widget
    return MessagePage();
  }

  Widget _buildProfileContent() {
    // Replace this with your Profile content widget
    return ProfileDetails(widget.currentUser);
  }

  Widget _buildSelectedContent() {
    switch (_currentIndex) {
      case 0:
        return _buildDiscoverContent();
      case 1:
        return _buildListContent();
      case 2:
        return _buildChatContent();
      case 3:
        return _buildProfileContent();

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              'assets/image/Mlogo.svg', // Path to the SVG icon
              width: 180,
              height: 38,
            ),
            SizedBox(width: 10),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                _searchIndex = 3;
              });
              await _authService.getUserLocation(widget.currentUser);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FilterPage(
              //         widget.currentUser,  userLocation),
              //   ),
              // );

              // Handle settings button press
            },
            icon: SvgPicture.asset(
              'assets/image/settings.svg', // Path to the SVG icon
              width: 30,
              height: 30,
              color: _searchIndex == 3 ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 5,
            thickness: 1,
            color: Color(0xFFCFCDCD),
          ),
          Expanded(
            child: _buildSelectedContent(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ProfileSearchPage()),
            // );
          }
          if (index == 1) {
            // redirection
          }
          if (index == 2) {
            // redirection
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: 1.3,
              child: SvgPicture.asset(
                'assets/image/discover.svg',
                width: 120,
                height: 60,
                color: _currentIndex == 0 ? Colors.black : Colors.grey,
              ),
            ),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: 1.3,
              child: SvgPicture.asset(
                'assets/image/list.svg',
                width: 120,
                height: 60,
                color: _currentIndex == 1 ? Colors.black : Colors.grey,
              ),
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: 1.3,
              child: SvgPicture.asset(
                'assets/image/chat.svg',
                width: 120,
                height: 60,
                color: _currentIndex == 2 ? Colors.black : Colors.grey,
              ),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: 1.3,
              child: SvgPicture.asset(
                'assets/image/profile.svg',
                width: 120,
                height: 60,
                color: _currentIndex == 3 ? Colors.black : Colors.grey,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
