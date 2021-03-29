import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ContentData {
  Future<dynamic> queryNumLevel() async {
    return await rootBundle.loadString('assets/ContentLevelLesson.json');
  }

  Future<List<Map<String, String>>> getVocabulary(
      int numLevel, int numLesson) async {
    String data = await rootBundle.loadString('assets/ContentLevelLesson.json');
    Map<String, dynamic> map =
        jsonDecode(data)['level-$numLevel']['lesson-$numLesson']['vocabulary'];

    List<Map<String, String>> list = [];
    map.forEach((key, word) {
      list.add({
        "wordInSpanish": word["wordInSpanish"],
        "wordInChatino": word["wordInChatino"],
        "pathBackground": word["pathBackground"],
        "pathSound": word["pathSound"]
      });
    });

    return list;
  }

  Future<Map<String, dynamic>> getPronunciaton(int numLevel, int numLesson,
      String typePronunciaton, String letter) async {
    String data = await rootBundle.loadString('assets/ContentLevelLesson.json');
    Map<String, dynamic> mapLetter = jsonDecode(data)['level-$numLevel']
        ['lesson-$numLesson']['pronunciaton'][typePronunciaton][letter];
    return mapLetter;
  }

  Future<Map<String, dynamic>> getExercise(
      int numLevel, int numLesson, int numExercise) async {
    Future<dynamic> data =
        rootBundle.loadString('assets/ContentLevelLesson.json');
    Map<String, dynamic> list = jsonDecode(await data);
    return list['level-$numLevel']['lesson-$numLesson']['exercises']
        ['act-$numExercise'];
  }

  Future<String> getConversation(int numLevel, int numLesson) async {
    Future<dynamic> data =
        rootBundle.loadString('assets/ContentLevelLesson.json');
    Map<String, dynamic> list = jsonDecode(await data);
    return list['level-$numLevel']['lesson-$numLesson']['conversation']
        ['pathVideo'];
  }
}
