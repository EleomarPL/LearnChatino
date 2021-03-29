import 'package:flutter/material.dart';
import '../../../../contentData/ContentData.dart';
import '../../../../database/Storage.dart';
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
  Storage _storage = Storage();

  Widget _fillListVowel(String letter) {
    return FutureBuilder(
        future: _contentData.getPronunciaton(
            widget.numLevel, widget.numLesson, "longvowels", letter),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return FutureBuilder(
                future: _storage.getImageAndURLSound(
                    snapshot.data['pathImage'].toString(),
                    snapshot.data['pathSound'].toString()),
                builder:
                    (BuildContext c, AsyncSnapshot<Map<String, String>> s) {
                  if (s.hasData) {
                    return ComponentPronunciaton(
                      imageURL: s.data['imageURL'],
                      wordInSpanish: snapshot.data['wordInSpanish'].toString(),
                      wordInChatino: snapshot.data['wordInChatino'].toString(),
                      soundURL: s.data['soundURL'],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
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
