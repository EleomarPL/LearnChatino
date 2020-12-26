import 'package:flutter/material.dart';
import '../../../../contentData/ContentData.dart';

import '../components/ComponentBody.dart';
import 'components/ComponentPronunciaton.dart';

class LongVowels extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  LongVowels({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _LongVowelsState createState() => _LongVowelsState();
}

class _LongVowelsState extends State<LongVowels> {
  List<String> _tabLongVowels = ["aa", "ee", "ii", "oo", "uu"];
  ContentData _contentData = ContentData();
  Widget _fillListVowel(String letter) {
    return FutureBuilder(
        future: _contentData.getPronunciaton(
            widget.numLevel, widget.numLesson, "longvowels", letter),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ComponentPronunciaton(
              pathImage: snapshot.data['pathImage'].toString(),
              wordInSpanish: snapshot.data['wordInSpanish'].toString(),
              wordInChatino: snapshot.data['wordInChatino'].toString(),
              pathSound: snapshot.data['pathSound'].toString(),
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
    return ComponentBody(
      numLevel: widget.numLevel,
      numLesson: widget.numLesson,
      lengthTabBar: 5,
      lengthText: 40,
      backgroundColor: Colors.white,
      labelSelectedColor: Colors.red[600],
      labelUnselectedColor: Colors.grey[600],
      backgroundBoxSelectec: Colors.white,
      listTabBar: _tabLongVowels,
      listTabBarView: _tabLongVowels.map((e) {
        return _fillListVowel(e);
      }).toList(),
    );
  }
}
