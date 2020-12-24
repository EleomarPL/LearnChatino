import 'package:flutter/material.dart';
import '../../contentData/ContentData.dart';
import 'ComponentLevel.dart';
import 'dart:convert';

class MainMain extends StatefulWidget {
  MainMain({Key key}) : super(key: key);

  @override
  _MainMainState createState() => _MainMainState();
}

class _MainMainState extends State<MainMain> {
  ContentData contentData = ContentData();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          FutureBuilder(
              future: contentData.queryNumLevel(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> listJSON = jsonDecode(snapshot.data);
                  return Column(
                    children: [
                      for (int i = 0; i < listJSON.length; i++)
                        ComponentLevel(
                          numLevel: (i + 1),
                          isAccessibleLessonOne: (i == 0) ? true : false,
                          isAccessibleLessonTwo: false,
                          isAccessibleLessonThree: false,
                        )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
