import 'package:flutter/material.dart';

class LongVowels extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  LongVowels({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _LongVowelsState createState() => _LongVowelsState();
}

class _LongVowelsState extends State<LongVowels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Long vowels'),
    );
  }
}
