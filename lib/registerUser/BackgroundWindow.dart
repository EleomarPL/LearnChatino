import 'package:flutter/material.dart';

class BackgroundWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/registerUser/backgroundRegister.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
