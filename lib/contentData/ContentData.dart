import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ContentData {
  Future<dynamic> queryNumLevel() async {
    return await rootBundle.loadString('assets/ContentLevelLesson.json');
  }

  Future<Map<String, dynamic>> getVocabulary(
      int numLevel, int numLesson) async {
    Future<dynamic> data =
        rootBundle.loadString('assets/ContentLevelLesson.json');
    Map<String, dynamic> list = jsonDecode(await data);
    return list['level-$numLevel']['lesson-$numLesson']['vocabulary'];
  }

  Future<Map<String, dynamic>> getPronunciaton(int numLevel, int numLesson,
      String typePronunciaton, String letter) async {
    Future<dynamic> data =
        rootBundle.loadString('assets/ContentLevelLesson.json');
    Map<String, dynamic> list = jsonDecode(await data);
    return list['level-$numLevel']['lesson-$numLesson']['pronunciaton']
        [typePronunciaton][letter];
  }

  Future<Map<String, dynamic>> getExercise(
      int numLevel, int numLesson, int numExercise) async {
    Future<dynamic> data =
        rootBundle.loadString('assets/ContentLevelLesson.json');
    Map<String, dynamic> list = jsonDecode(await data);
    return list['level-$numLevel']['lesson-$numLesson']['exercises']
        ['act-$numExercise'];
  }
}
