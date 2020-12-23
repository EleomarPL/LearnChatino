import 'package:flutter/material.dart';
import '../components/ComponentBody.dart';
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
      body: ComponentBody(
        numLevel: widget.numLevel,
        numLesson: widget.numLesson,
        lengthTabBar: 10,
        lengthText: 25,
        backgroundColor: Colors.grey,
        labelSelectedColor: Colors.white,
        labelUnselectedColor: Colors.black,
        backgroundBoxSelectec: Colors.red,
        listTabBar: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
        listTabBarView: [
          Text("Widgets of tab exercise 1 is here"),
          Text("Widgets of tab exercise 2 is here"),
          Text("Widgets of tab exercise 3 is here"),
          Text("Widgets of tab exercise 4 is here"),
          Text("Widgets of tab exercise 5 is here"),
          Text("Widgets of tab exercise 6 is here"),
          Text("Widgets of tab exercise 7 is here"),
          Text("Widgets of tab exercise 8 is here"),
          Text("Widgets of tab exercise 9 is here"),
          Text("Widgets of tab exercise 10 is here"),
        ],
      ),
    );
  }
}
