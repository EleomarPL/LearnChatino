import 'package:flutter/material.dart';
import 'package:learn_chatino/windowsLesson/mainTab/lesson/HeaderWindowLesson.dart';
import 'package:learn_chatino/windowsLesson/mainTab/lesson/vocabulary/ComponentVocabulary.dart';

class MainVocabulary extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  MainVocabulary({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _MainVocabularyState createState() => _MainVocabularyState();
}

class _MainVocabularyState extends State<MainVocabulary> {
  @override
  Widget build(BuildContext context) {
    return HeaderWindowLesson(
      lesson: 'Lección ${widget.numLesson}',
      titleBody: 'Vocabulario',
      body: Column(
        children: [
          ComponentVocabulary(
            wordInSpanish: 'Bienvenido',
            pathImage: 'assets/background.png',
          ),
        ],
      ),
    );
  }
}
