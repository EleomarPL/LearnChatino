import 'package:flutter/material.dart';

class MainConversation extends StatefulWidget {
  MainConversation({Key key}) : super(key: key);

  @override
  _MainConversationState createState() => _MainConversationState();
}

class _MainConversationState extends State<MainConversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aprendamos Chatino"),
      ),
    );
  }
}
