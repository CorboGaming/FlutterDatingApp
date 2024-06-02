// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';
import 'package:mahram_optimise_v01/widgets/aboutMeWidget.dart';
import 'package:mahram_optimise_v01/widgets/descriptionTextWidget.dart';
import 'package:mahram_optimise_v01/widgets/educationAndCarrerWidget.dart';
import 'package:mahram_optimise_v01/widgets/footerWidget.dart';
import 'package:mahram_optimise_v01/widgets/placeHolder.dart';
import 'package:mahram_optimise_v01/widgets/religiosityWidget.dart';

class CardSwiperProfile extends StatefulWidget {
  final UsersEntity currentUser;
  const CardSwiperProfile(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<CardSwiperProfile> createState() => _ProfileTestState();
}

class _ProfileTestState extends State<CardSwiperProfile> {
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  List<UsersEntity> usersList = [];
  final ScrollController _scrollController = ScrollController();
  bool isLike = false;
  bool isPass = false;
  bool isSwiping = false;
  int currentIndex = 0; // Variable to store the current index
  bool showDetails = false;
  Timer? likeTimer;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Color Infocolor = const Color.fromARGB(255, 119, 119, 119).withOpacity(0.1);

  Future<void> getUsers() async {
    QuerySnapshot querySnapshot = await usersCollection.get();

    setState(() {
      usersList = querySnapshot.docs
          .map((doc) => UsersEntity.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  final CardSwiperController _usernameSwiperController = CardSwiperController();

  FutureOr<bool> _usernameOnSwipe(
    int previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    switch (direction) {
      case CardSwiperDirection.left:
        _usernameSwiperController.swipeLeft();

        break;
      case CardSwiperDirection.right:
        _usernameSwiperController.swipeRight();
        break;
      default:
        break;
    }

    return true;
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void scrollToSecondCard() {
    _scrollController.animateTo(
      MediaQuery.of(context).size.height * 0.78,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.78, // Use full screen height
              child: usersList.isNotEmpty
                  ? CardSwiper(
                      cardsCount: usersList.length,
                      backCardOffset: Offset.zero,
                      cardBuilder: (context, index, percentThresholdX,
                          percentThresholdY) {
                        return Card(
                          color: Colors.white,
                          shadowColor: null,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  usersList[index].photoList,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                // top: MediaQuery.of(context).size.height *
                                //     0.55, // Center vertically
                                left: 60,
                                right: 0,
                                bottom: 80,

                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${capitalizeFirstLetter(usersList[index].username)}  ${usersList[index].age}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        const Icon(
                                          Icons.verified,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    //location row
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Color(0xFF31C48D),
                                          size: 18,
                                        ),
                                        Text(
                                          '${usersList[index].pays} ', // Display the user's location
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: -1,
                                left: 40,
                                right: 30,
                                child: Transform.translate(
                                  offset: const Offset(0, 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (!isSwiping) {
                                            // Check the flag to disable the onTap functionality during swipe
                                            _usernameSwiperController
                                                .swipeLeft();

                                            setState(() {
                                              isLike = false;
                                              isPass = true;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.95),
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 5,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.clear_rounded,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showDetails = !showDetails;
                                          });
                                          if (showDetails) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              scrollToSecondCard();
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 5,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            !showDetails
                                                ? Icons.keyboard_arrow_down
                                                : Icons.keyboard_arrow_up,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (!isSwiping) {
                                            // Check the flag to disable the onTap functionality during swipe
                                            _usernameSwiperController
                                                .swipeRight();

                                            setState(() {
                                              isPass = false;
                                              isLike = true;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                blurRadius: 5,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.favorite_border,
                                            color: Color(0xFF31C48D),
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // if (isPass)
                              //   Positioned(
                              //     top: 50,
                              //     left: -35,
                              //     child: Transform.rotate(
                              //       angle: -45,
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //           border: Border.all(
                              //               color: Colors.red, width: 6),
                              //         ),
                              //         child: Text(
                              //           ' PASS',
                              //           style: TextStyle(
                              //               color: Colors.red.withOpacity(0.9),
                              //               fontWeight: FontWeight.w900,
                              //               fontSize: 50),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // if (isLike)
                              //   Positioned(
                              //     top: 50,
                              //     right: -35,
                              //     child: Transform.rotate(
                              //       angle: -45,
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //           border: Border.all(
                              //               color: Colors.green, width: 6),
                              //         ),
                              //         child: Text(
                              //           ' LIKE',
                              //           style: TextStyle(
                              //               color:
                              //                   Colors.green.withOpacity(0.9),
                              //               fontWeight: FontWeight.w900,
                              //               fontSize: 50),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                            ],
                          ),
                        );
                      },
                      controller: _usernameSwiperController,
                      onSwipe: (previousIndex, currentIndex, direction) {
                        if (currentIndex != null) {
                          setState(() {
                            isSwiping =
                                true; // Set the flag to true during the swipe action

                            if (direction == CardSwiperDirection.right) {
                              isLike = true;
                            } else if (direction == CardSwiperDirection.left) {
                              isPass = true;
                            }

                            this.currentIndex = currentIndex;
                          });

                          Future.microtask(() {
                            setState(() {
                              isLike = false;
                              isPass = false;
                              isSwiping =
                                  false; // Reset the flag after the swipe action is completed
                            });
                          });

                          _usernameOnSwipe(
                              previousIndex, currentIndex, direction);
                        }

                        return true;
                      },
                    )
                  : PlaceholderCard(),
            ),

            // this is the second card
            if (showDetails)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return FractionallySizedBox(
                    widthFactor: 0.9, // Adjust the width factor as needed
                    child: usersList.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              boxShadow: const [], // Remove shadows
                              borderRadius:
                                  BorderRadius.circular(8), // Remove edges
                              color:
                                  Colors.transparent, // Remove background color
                            ),
                            child: SingleChildScrollView(
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide.none, // Remove borders
                                ),
                                elevation: 0,
                                child: Column(
                                  children: [
                                    Wrap(
                                      runSpacing: 10,
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.only(
                                              left: 15,
                                            ),
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: capitalizeFirstLetter(
                                                        usersList[currentIndex]
                                                            .username),
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' ${usersList[currentIndex].age}',
                                                    style: const TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      // Add any other styles for the age here
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                color: Color(0xFF31C48D),
                                                size: 18,
                                              ),
                                              Text(
                                                  '${usersList[currentIndex].pays} ')
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Color(0xFFCFCDCD),
                                      thickness: 0.5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                        left: 15,
                                        top: 30,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'About me',
                                            style: TextStyle(
                                              fontFamily: GoogleFonts.roboto()
                                                  .fontFamily,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          AboutMeWidget(
                                            usersList[currentIndex].taille,
                                            usersList[currentIndex]
                                                .statutMarital,
                                            usersList[currentIndex].enfants,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                        left: 15,
                                        top: 30,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Religiosity',
                                            style: TextStyle(
                                              fontFamily: GoogleFonts.roboto()
                                                  .fontFamily,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          ReligiosityWidget(
                                            usersList[currentIndex].dressCode,
                                            usersList[currentIndex]
                                                .pratiqueReligieuse,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                        left: 15,
                                        top: 30,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Education and carrer',
                                            style: TextStyle(
                                              fontFamily: GoogleFonts.roboto()
                                                  .fontFamily,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          EducationAndCarrerWidget(
                                            usersList[currentIndex].langues,
                                            usersList[currentIndex].education,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      margin: EdgeInsets.only(
                                        left: 15,
                                        top: 30,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Description',
                                            style: TextStyle(
                                              fontFamily: GoogleFonts.roboto()
                                                  .fontFamily,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          DescriptionTextWidget(
                                            usersList[currentIndex].description,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Divider(
                                      color: Color(0xFFCFCDCD),
                                      thickness: 0.5,
                                    ),
                                    FooterWidget(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : PlaceholderCard(),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
