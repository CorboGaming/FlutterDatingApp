import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 24, top: 50, bottom: 120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(
                Icons.do_disturb_alt_outlined,
                size: 30,
                color: Colors.black.withOpacity(0.9),
              ),
              const Text('Block'),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.favorite_border,
                size: 30,
                color: Colors.black.withOpacity(0.9),
              ),
              const Text('Favorite'),
            ],
          ),
          Column(
            children: [
              Icon(
                Icons.flag_outlined,
                size: 30,
                color: Colors.black.withOpacity(0.9),
              ),
              const Text('Report'),
            ],
          ),
        ],
      ),
    );
  }
}
