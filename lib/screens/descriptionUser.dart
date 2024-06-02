import 'package:flutter/material.dart';
import 'package:mahram_optimise_v01/models/usersEntity.dart';

class DescriptionUser extends StatefulWidget {
  final UsersEntity currentUser;

  DescriptionUser(this.currentUser, {Key? key}) : super(key: key);

  @override
  State<DescriptionUser> createState() => _DescriptionUserState();
}

class _DescriptionUserState extends State<DescriptionUser> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
