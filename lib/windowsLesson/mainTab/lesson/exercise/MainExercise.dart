import 'package:flutter/material.dart';

class MainExercise extends StatefulWidget {
  MainExercise({Key key}) : super(key: key);

  @override
  _MainExerciseState createState() => _MainExerciseState();
}

class _MainExerciseState extends State<MainExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprendamos Chatino"),
      ),
    );
  }
}
