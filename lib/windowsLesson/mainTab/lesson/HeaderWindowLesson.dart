import 'package:flutter/material.dart';

class HeaderWindowLesson extends StatelessWidget {
  final Widget body;
  final String lesson;
  final String titleBody;

  const HeaderWindowLesson({Key key, this.body, this.lesson, this.titleBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprendamos Chatino"),
        elevation: 0,
        bottom: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text(
            '$lesson',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            '$titleBody',
            style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.w900,
                color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: body,
      ),
    );
  }
}
