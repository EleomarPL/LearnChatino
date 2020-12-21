import 'package:flutter/material.dart';
import 'package:learn_chatino/windowsLesson/mainTab/ComponentLevel.dart';

class MainMain extends StatefulWidget {
  //MainMain({Key key}) : super(key: key);

  @override
  _MainMainState createState() => _MainMainState();
}

class _MainMainState extends State<MainMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          //ComponentLevel(),
          ComponentLevel(
            numLevel: 1,
            isAccessibleLessonOne: true,
            isAccessibleLessonTwo: false,
            isAccessibleLessonThree: false,
          ),
          ComponentLevel(
            numLevel: 2,
            isAccessibleLessonOne: false,
            isAccessibleLessonTwo: false,
            isAccessibleLessonThree: false,
          ),
        ],
      ),
    );
  }
}
