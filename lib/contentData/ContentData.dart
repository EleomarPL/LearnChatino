import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ContentData {
  String _dataJSON;
  init() async {
    _dataJSON = await rootBundle.loadString('assets/ContentLevelLesson.json');
  }

  Future<dynamic> queryNumLevel() async {
    return await rootBundle.loadString('assets/ContentLevelLesson.json');
    //Map<Stri data = await _loadAStudentAsset();

    /*data.then((value) {
      Map<String, dynamic> list = jsonDecode(value);
      print(list['level-1']);
    });*/
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
}
