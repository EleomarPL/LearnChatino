import 'package:flutter/material.dart';
import '../HeaderWindowLesson.dart';

class MainConversation extends StatefulWidget {
  final int numLevel;
  final int numLesson;
  MainConversation({Key key, this.numLevel, this.numLesson}) : super(key: key);

  @override
  _MainConversationState createState() => _MainConversationState();
}

class _MainConversationState extends State<MainConversation> {
  @override
  Widget build(BuildContext context) {
    return HeaderWindowLesson(
      lesson: 'Lección ${widget.numLesson}',
      titleBody: 'Conversación',
      body: Column(
        children: [],
      ),
    );
  }
}
