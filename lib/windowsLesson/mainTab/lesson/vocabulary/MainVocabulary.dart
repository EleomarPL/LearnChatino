import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprendamos Chatino"),
        elevation: 0,
        bottom: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text(
            'Leccion ${widget.numLesson}',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            'Vocabulario',
            style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w900,
                color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            //Example component vocabulary
            ComponentVocabulary(
              wordInSpanish: "Bienvenido",
              pathImage: "assets/background.png",
            )
          ],
        ),
      ),
    );
  }
}
