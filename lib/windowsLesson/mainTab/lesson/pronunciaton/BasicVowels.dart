import 'package:flutter/material.dart';
import '../../../../contentData/ContentData.dart';
import 'components/ComponentPronunciaton.dart';
import '../components/ComponentBody.dart';

class BasicVowels extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  BasicVowels({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _BasicVowelsState createState() => _BasicVowelsState();
}

class _BasicVowelsState extends State<BasicVowels> {
  List<String> _tabBasicVowels = ["a", "e", "i", "o", "u"];
  ContentData _contentData = ContentData();
  Widget _fillListVowel(String letter) {
    return FutureBuilder(
        future: _contentData.getPronunciaton(
            widget.numLevel, widget.numLesson, "basicvowels", letter),
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
      listTabBar: _tabBasicVowels,
      listTabBarView: _tabBasicVowels.map((e) {
        return _fillListVowel(e);
      }).toList(),
    );
  }
}
