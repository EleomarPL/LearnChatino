import 'package:flutter/material.dart';
import '../../contentData/ContentData.dart';
import 'ComponentLevel.dart';
import 'dart:convert';
import '../../database/MainDatabase.dart';
import '../../database/ObjectTables.dart';

class MainMain extends StatefulWidget {
  final int idUser;
  final int typeUser;
  MainMain({Key key, this.idUser, this.typeUser}) : super(key: key);

  @override
  _MainMainState createState() => _MainMainState();
}

_registerInitialValue(int idUser, int numLevels, int numLevelsRegister,
    MainDatabase mainDatabase) async {
  if (numLevelsRegister == 0) {
    await mainDatabase.registerInitialAdvanceLevel(idUser, numLevels);
  }
}

Widget _fillComponentLevel(
    int i,
    int numLevels,
    int numLevelsRegister,
    List<ProgressUser> progressUser,
    int idUser,
    int typeUser,
    Function callbackRefresh) {
  Map<String, int> lessonLevel = {
    "lesson-1": (((numLevelsRegister / numLevels) * i)).toInt(),
    "lesson-2": (((numLevelsRegister / numLevels) * i) + 1).toInt(),
    "lesson-3": (((numLevelsRegister / numLevels) * i) + 2).toInt()
  };
  return ComponentLevel(
    idUser: idUser,
    typeUser: typeUser,
    numLevel: (i + 1),
    callbackRefresh: callbackRefresh,
    isAccessibleLessonOne: (i == 0)
        ? true
        : (progressUser[lessonLevel['lesson-1'] - 1].exercise == 10)
            ? true
            : false,
    isAccessibleLessonTwo:
        (progressUser[lessonLevel['lesson-2'] - 1].exercise == 10)
            ? true
            : false,
    isAccessibleLessonThree:
        (progressUser[lessonLevel['lesson-3'] - 1].exercise == 10)
            ? true
            : false,
    isFinishedLessonOne:
        (progressUser[lessonLevel['lesson-1']].exercise == 10) ? true : false,
    isFinishedLessonTwo:
        (progressUser[lessonLevel['lesson-2']].exercise == 10) ? true : false,
    isFinishedLessonThree:
        (progressUser[lessonLevel['lesson-3']].exercise == 10) ? true : false,
  );
}

Widget fillLevels(
    int idUser,
    ContentData contentData,
    List<ProgressUser> listUser,
    MainDatabase mainDatabase,
    int typeUser,
    Function callbackRefresh) {
  return FutureBuilder(
      future: contentData.queryNumLevel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> listJSON = jsonDecode(snapshot.data);
          _registerInitialValue(
              idUser, listJSON.length, listUser.length, mainDatabase);
          return Column(
            children: [
              for (int i = 0; i < listJSON.length; i++)
                if (listUser.length == 0)
                  ComponentLevel(
                    idUser: idUser,
                    typeUser: typeUser,
                    numLevel: (i + 1),
                    callbackRefresh: callbackRefresh,
                    isAccessibleLessonOne: (i == 0) ? true : false,
                    isAccessibleLessonTwo: false,
                    isAccessibleLessonThree: false,
                    isFinishedLessonOne: false,
                    isFinishedLessonTwo: false,
                    isFinishedLessonThree: false,
                  )
                else
                  _fillComponentLevel(i, listJSON.length, listUser.length,
                      listUser, idUser, typeUser, callbackRefresh),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      });
}

_validateData(
    BuildContext context,
    MainDatabase mainDatabase,
    ContentData contentData,
    int idUser,
    int typeUser,
    Function callbackRefresh) {
  return FutureBuilder(
    future: mainDatabase.getProgressUser(idUser),
    builder:
        (BuildContext context, AsyncSnapshot<List<ProgressUser>> snapshot) {
      if (snapshot.hasData) {
        return fillLevels(idUser, contentData, snapshot.data, mainDatabase,
            typeUser, callbackRefresh);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

class _MainMainState extends State<MainMain> {
  ContentData contentData = ContentData();
  MainDatabase mainDatabase = MainDatabase();

  refreshPage() {
    setState(() {
      this.reassemble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          (widget.typeUser == 0)
              ? FutureBuilder(
                  future: mainDatabase.initDB(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _validateData(context, mainDatabase, contentData,
                          widget.idUser, widget.typeUser, refreshPage);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              : FutureBuilder(
                  future: contentData.queryNumLevel(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> listJSON = jsonDecode(snapshot.data);
                      return Column(
                        children: [
                          for (int i = 0; i < listJSON.length; i++)
                            ComponentLevel(
                              idUser: widget.idUser,
                              typeUser: widget.typeUser,
                              numLevel: (i + 1),
                              callbackRefresh: refreshPage,
                              isAccessibleLessonOne: true,
                              isAccessibleLessonTwo: true,
                              isAccessibleLessonThree: true,
                              isFinishedLessonOne: true,
                              isFinishedLessonTwo: true,
                              isFinishedLessonThree: true,
                            )
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })

          //fillLevels(contentData),
        ],
      ),
    );
  }
}
