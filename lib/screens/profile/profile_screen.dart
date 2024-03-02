import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Proflie',
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Body(),
    );
  }
}
