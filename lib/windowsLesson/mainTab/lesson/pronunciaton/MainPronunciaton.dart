import 'package:flutter/material.dart';

class MainPronunciaton extends StatefulWidget {
  MainPronunciaton({Key key}) : super(key: key);

  @override
  _MainPronunciatonState createState() => _MainPronunciatonState();
}

class _MainPronunciatonState extends State<MainPronunciaton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprendamos Chatino"),
      ),
    );
  }
}
