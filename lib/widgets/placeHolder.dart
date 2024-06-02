import 'package:flutter/material.dart';

class PlaceholderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          alignment: Alignment.center, child: CircularProgressIndicator()),
    );
  }
}
