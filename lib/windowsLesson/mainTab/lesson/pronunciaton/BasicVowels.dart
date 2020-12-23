import 'package:flutter/material.dart';
import 'components/ComponentBody.dart';

class BasicVowels extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  BasicVowels({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _BasicVowelsState createState() => _BasicVowelsState();
}

class _BasicVowelsState extends State<BasicVowels> {
  @override
  Widget build(BuildContext context) {
    return ComponentBody(
      numLevel: widget.numLevel,
      numLesson: widget.numLesson,
      lengthTabBar: 5,
      listTabBar: ["a", "e", "i", "o", "u"],
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
