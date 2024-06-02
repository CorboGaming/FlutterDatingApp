import 'package:flutter/material.dart';

class LikeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -45,
      child: Container(
        child: Center(
          child: Image.asset(
            'assets/image/likeuser.png',
            width: 150,
            color: Color.fromARGB(255, 78, 235, 177).withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
