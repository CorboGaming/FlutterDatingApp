import 'package:flutter/material.dart';

class PassWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 45,
      child: Container(
        child: Center(
          child: Image.asset(
            'assets/image/passuser.png',
            width: 150,
            color: Colors.red.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
