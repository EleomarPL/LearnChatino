import 'package:flutter/material.dart';

import '../components/ComponentBody.dart';

class LongVowels extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  LongVowels({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _LongVowelsState createState() => _LongVowelsState();
}

class _LongVowelsState extends State<LongVowels> {
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
      listTabBar: ["aa", "ee", "ii", "oo", "uu"],
      listTabBarView: [
        Text("Widgets of tab aa is here"),
        Text("Widgets of tab ee is here"),
        Text("Widgets of tab ii is here"),
        Text("Widgets of tab oo is here"),
        Text("Widgets of tab uu is here"),
      ],
    );
  }
}
