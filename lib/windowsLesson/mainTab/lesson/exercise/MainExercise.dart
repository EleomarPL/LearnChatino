import 'package:flutter/material.dart';
import '../../../../contentData/ContentData.dart';
import 'ComponentExercise.dart';
import '../components/ComponentBody.dart';
import '../HeaderWindowLesson.dart';

class MainExercise extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  final int idUser;
  final int typeUser;
  MainExercise(
      {Key key, this.numLevel, this.numLesson, this.idUser, this.typeUser})
      : super(key: key);

  @override
  _MainExerciseState createState() => _MainExerciseState();
}

class _MainExerciseState extends State<MainExercise> {
  List<String> _tabExercise = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  ContentData _contentData = ContentData();
  Widget _fillListVowel(int numExercise) {
    return FutureBuilder(
        future: _contentData.getExercise(
            widget.numLevel, widget.numLesson, numExercise),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ComponentExercise(
              idUser: widget.idUser,
              typeUser: widget.typeUser,
              numExercise: numExercise,
              numLesson: widget.numLesson,
              numLevel: widget.numLevel,
              correctWord1: snapshot.data['correctWord1'].toString(),
              incorrectWord1: snapshot.data['incorrectWord1'].toString(),
              correctWord2: snapshot.data['correctWord2'].toString(),
              incorrectWord2: snapshot.data['incorrectWord2'].toString(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

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
        listTabBar: _tabExercise,
        listTabBarView: _tabExercise.map((e) {
          return _fillListVowel(int.tryParse(e));
        }).toList(),
      ),
    );
  }
}
