// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mahram_optimise_v01/widgets/ListUserWidget/blockedUserList.dart';
import 'package:mahram_optimise_v01/widgets/ListUserWidget/favouritedUserList.dart';
import 'package:mahram_optimise_v01/widgets/ListUserWidget/matchedUser.dart';
import 'package:mahram_optimise_v01/widgets/ListUserWidget/vistedUserList.dart';

class ListUserWidget extends StatefulWidget {
  @override
  _ListUserWidgetState createState() => _ListUserWidgetState();
}

class _ListUserWidgetState extends State<ListUserWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _tabController,
          labelPadding: EdgeInsets.symmetric(
              horizontal: 5.0), // Adjust the padding as needed

          tabs: [
            Tab(text: 'Match'),
            Tab(text: 'Favourite'),
            Tab(text: 'Profile visité'),
            Tab(text: 'Bloquer'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Mathed Widget
          Center(
            child: MatchedUserList(),
          ),
          // Favourited Widget
          Center(
            child: FavouritedUserList(),
          ),
          // Visit You Widget

          Center(
            child: VisitedUserList(),
          ),
          // Blocked Widget
          Center(
            child: BlockedUserList(),
          ),
        ],
      ),
    );
  }
}
