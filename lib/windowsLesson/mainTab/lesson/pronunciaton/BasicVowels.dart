import 'package:flutter/material.dart';

class BasicVowels extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  BasicVowels({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _BasicVowelsState createState() => _BasicVowelsState();
}

class _BasicVowelsState extends State<BasicVowels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Basic vowels'),
    );
  }
}
