import 'package:flutter/material.dart';
import 'package:learn_chatino/windowsLesson/mainTab/lesson/HeaderWindowLesson.dart';
import 'package:learn_chatino/windowsLesson/mainTab/lesson/pronunciaton/BasicVowels.dart';
import 'package:learn_chatino/windowsLesson/mainTab/lesson/pronunciaton/LongVowels.dart';

class BaseWindowPronunciaton extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  final bool isBasicVowel;
  BaseWindowPronunciaton(
      {Key key, this.numLevel, this.numLesson, this.isBasicVowel})
      : super(key: key);

  @override
  _BaseWindowPronunciatonState createState() => _BaseWindowPronunciatonState();
}

class _BaseWindowPronunciatonState extends State<BaseWindowPronunciaton> {
  @override
  Widget build(BuildContext context) {
    return HeaderWindowLesson(
      lesson: 'Lección ${widget.numLesson}',
      titleBody: 'Pronunciación',
      body: (widget.isBasicVowel)
          ? BasicVowels(
              numLesson: widget.numLesson,
              numLevel: widget.numLevel,
            )
          : LongVowels(
              numLesson: widget.numLesson,
              numLevel: widget.numLevel,
            ),
    );
  }
}
