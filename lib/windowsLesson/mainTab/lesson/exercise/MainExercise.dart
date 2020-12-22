import 'package:flutter/material.dart';
import '../HeaderWindowLesson.dart';

class MainExercise extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  MainExercise({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _MainExerciseState createState() => _MainExerciseState();
}

class _MainExerciseState extends State<MainExercise> {
  @override
  Widget build(BuildContext context) {
    return HeaderWindowLesson(
      lesson: 'Lección ${widget.numLesson}',
      titleBody: 'Ejercicios',
      body: Column(
        children: [],
      ),
    );
  }
}
